//
//  AddProductView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 15/03/25.
//

import SwiftUI

struct EditProductView: View {
    /// The view model for managing the addition of shopping lists.
    var viewModel = AddListViewModel()

    /// The shopping list item to which the product belongs.
    var item: ListModel

    /// The product being edited, or `nil` if adding a new product.
    var product: Product?

    /// The environment variable for dismissing the view.
    @Environment(\.dismiss) var dismiss

    /// The state for the product's name.
    @State private var text: String

    /// The state for the product's price.
    @State private var price: String

    /// The state for the product's note or description.
    @State private var note: String

    /// The state for the product's quantity.
    @State private var quantity: Int

    /// The state for the product's category.
    @State private var category: String

    /// Initializes the `EditProductView` with the required parameters.
    /// - Parameters:
    ///   - item: The shopping list item.
    ///   - product: The product to edit, or `nil` to add a new product.
    init(item: ListModel, product: Product? = nil) {
        self.item = item
        self.product = product
        _text = State(initialValue: product?.name ?? "")
        _price = State(initialValue: product?.price?.formatted() ?? "")
        _note = State(initialValue: product?.note ?? "")
        _quantity = State(initialValue: product?.quantity ?? 1)
        _category = State(initialValue: product?.category ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("NOME DO ITEM")
                .bold()
                .foregroundStyle(.white.opacity(0.6))
            
            VStack {
                TextField("", text: $text, prompt: Text("Digite o nome do item").foregroundColor(.white))
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.white)
            }

            NavigationLink {
                CategoryListView(name: text, onSelect: { category in
                    product?.category = category
                    self.category = category
                })
            } label: {
                Text(self.category != "" ? self.category : "Adicionar Categoria").foregroundStyle(.black).bold()
            }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.white)
                .cornerRadius(20)
        }
            .frame(minHeight: 100)
            .padding()
            .background(Color.accentColor)
        List {
            
            Stepper(value: $quantity, in: 1...100) {
                HStack {
                    Text("Qtd").foregroundStyle(.primary.opacity(0.4))
                    Text(quantity.formatted())
                }
            }.padding(.vertical)

            HStack {
                Text("Preço").foregroundStyle(.primary.opacity(0.4))
                TextField("", text: $price)
                    .foregroundStyle(.primary)
            }.padding(.vertical)
            
            HStack {
                Text("Descrição").foregroundStyle(.primary.opacity(0.4))
                TextField("", text: $note)
                    .foregroundStyle(.primary)
            }.padding(.vertical)
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem {
                Button {
                    
                    if (product == nil) {
                        let productItem = Product(name: text, quantity: quantity, category: category, price: Double(price), note: note)
                        item.products?.append(productItem)
                    } else {
                        product?.name = text
                        product?.quantity = quantity
                        product?.price = Double(price)
                        product?.note = note
                        product?.category = category
                    }

                    dismiss()
                } label: {
                    Text(product != nil ? "Atualizar" : "Adicionar")
                }
                .bold()
                .foregroundColor(.white)
            }

            
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancelar")
                }
                .bold()
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProductView(item: ListModel(title: "MinhaLista", icon: "", color: 1))
    }

}
