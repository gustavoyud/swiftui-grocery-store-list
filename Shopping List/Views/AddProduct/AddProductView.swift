//
//  ProductView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 22/03/25.
//

import SwiftUI

struct AddProductView: View {
    /**
        The list model that will be used to create the products.
     */
    let item: ListModel
    
    /**
        The view model that will be used to create the products.
     */
    var viewModel = AddProductViewModel()
    
    /**
        The list of products that will be shown in the view.
     */
    @State private var filteredProducts = Product.mock
    
    /**
        The list of products that will be selected.
     */
    @State private var selectedProducts = Product.mock
    
    /**
        The list of products that will be selected.
     */
    @State private var searchText = ""
    
    /**
        The list of products that will be selected.
     */
    @State private var multiSelection = Set<Product>()
    
    /**
        A boolean to show the loading view.
     */
    @State private var loading = false
    
    /**
        A boolean to show the classification view.
     */
    @State private var enableClassification = true
    
    /**
        The context of the model.
     */
    @Environment(\.dismiss) var dismiss

    var body: some View {
        SearchInput(
            searchText: $searchText,
            placeholder: "Digite o nome do produto",
            onSearch: {_ in filterProducts()},
            onSubmit: {}
        )

        List {
            if !searchText.isEmpty {
                HStack {
                    Button {
                        let newProduct = Product(name: searchText, quantity: 1, category: "Outros")
                        selectedProducts.append(newProduct)
                        multiSelection.insert(newProduct)
                        searchText = ""
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 28))
                    }
                    Text(searchText)
                }
            }
                

            
            ForEach(filteredProducts, id: \.self) { product in
                Item(
                    multiSelection: multiSelection,
                    product: product,
                    onItemSelected: { product in multiSelection.insert(product) },
                    onItemDeselected: { product in multiSelection.remove(product) }
                )
            }
        }
        .listStyle(.plain)
        .toolbar {
            Button {
                Task {
                    loading = true
                    do {
                        try await viewModel.createProducts(list: multiSelection, model: item, enableClassification: enableClassification)
                        loading = false
                        dismiss()
                    } catch {
                        print("Error creating products: \(error)")
                        loading = false
                        dismiss()
                    }
                }
            } label: {
                if loading {
                    ProgressView()
                } else {
                    Text("Adicionar")
                }
            }
            Menu {
                Button {
                    enableClassification.toggle()
                } label: {
                    Label((enableClassification ? "Desabilitar" : "Habilitar") + " classificação", systemImage: "sparkles")
                }
                Button {
                } label: {
                    Label("Nova categoria", systemImage: "list.bullet.indent")
                }
            } label: {
                Label("Menu", systemImage: "ellipsis.circle")
            }

        }
    }

    private func filterProducts() {
        if searchText.isEmpty {
            filteredProducts = selectedProducts
        } else {
            filteredProducts = selectedProducts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    NavigationStack {
        AddProductView(item: ListModel(title: "MinhaLista", icon: "", color: 1))
    }
}

struct Item: View {
    var multiSelection = Set<Product>()
    var product: Product
    var onItemSelected: (Product) -> Void
    var onItemDeselected: (Product) -> Void
    var body: some View {
        HStack {
            Button {
                let isSelected = multiSelection.contains(product)

                if !isSelected {
                    onItemSelected(product)
                } else {
                    onItemDeselected(product)
                }

            } label: {
                let isSelected = multiSelection.contains(product)
                Image(systemName: isSelected ? "plus.circle.fill" : "plus.circle")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 28))
            }
            Text(product.name)
            Text("em \(product.category)").foregroundColor(.secondary)
        }
    }
}
