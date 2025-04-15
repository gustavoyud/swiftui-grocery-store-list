//
//  ListDetailView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 12/03/25.
//

import ActivityKit
import SwiftData
import SwiftUI
import UIKit

struct ProductListView: View {
    /**
        Activity helpter to manage live activities
     */
    var activityHelper = ActivityHelper.shared
    
    /**
        The list model
     */
    let listView: ListModel
    
    /**
        The colors list
     */
    @State private var colorsList: [Color] = [
        .blue,
        .green,
        .yellow,
        .orange,
        .pink,
        .purple,
        .red,
    ]
    
    /**
        A boolean to show only checked
     */
    @State private var onlyChecked: Bool = false
    
    /**
        The text to search for in the list
     */
    @State private var searchText = ""
    
    /**
        A boolean to show the settings modal
     */
    @State private var showModal: Bool = false
        
    /**
        The list of products that are selected
     */
    var selectedItems: [Product] {
        listView.products?.filter { $0.isChecked == true } ?? []
    }
    
    /**
        The list of products that are not selected
     */
    var unselectedItems: [Product] {
        listView.products?.filter { $0.isChecked == false } ?? []
    }
    

    var body: some View {
        let currentList = onlyChecked ? unselectedItems : listView.products

        let list = filterProducts(currentList ?? [])
        
        List {
            let groupedProducts = Dictionary(grouping: list, by: { $0.category })

            ForEach(groupedProducts.keys.sorted(), id: \.self) { category in
                let index = list.firstIndex(where: {
                    $0.category == category
                })!
                let color = colorsList[index % colorsList.count]
                Section(
                    header:
                    Text(category)
                        .font(.headline)
                        .bold()
                        .foregroundColor(color)
                ) {
                    ForEach(groupedProducts[category]!) { item in
                        HStack {
                            Button {
                                activityHelper.updateActivity()
                                item.isChecked.toggle()
                                let impactMed = UIImpactFeedbackGenerator(style: .light)
                                impactMed.impactOccurred()
                            } label: {
                                Image(
                                    systemName: item.isChecked
                                        ? "checkmark.circle.fill" : "circle"
                                )
                                .font(.custom("SF Pro", size: 22))
                                .foregroundColor(Color("AccentColor"))
                            }
                            

                            VStack(alignment: .leading) {
                                Text(item.name).strikethrough(
                                    item.isChecked)
                                if let note = item.note, !note.isEmpty {
                                    Text(note).foregroundStyle(.gray)
                                        .strikethrough(item.isChecked)
                                }
                            }

                            Spacer()
                            Text(item.quantity.formatted()).font(
                                .subheadline
                            )
                            .foregroundStyle(.gray)
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                listView.products?.removeAll(where: {
                                    $0.id == item.id
                                })
                            } label: {
                                Label("Deletar", systemImage: "trash.fill")
                            }

                            NavigationLink {
                                EditProductView(item: listView, product: item)
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(.gray)
                        }
                    }
                    .onDelete { listView.products?.remove(atOffsets: $0) }
                    .onMove {
                        listView.products?.move(
                            fromOffsets: $0, toOffset: $1)
                    }
                }
            }
        }


        .sheet(isPresented: $showModal) {
            ProductListConfigModalView(
                showModal: $showModal,
                onlyChecked: $onlyChecked,
                searchText: $searchText
            )
        }
        .scrollContentBackground(.hidden)
        .listStyle(.inset)
        .navigationTitle(
            selectedItems.count > 1
                ? "\(selectedItems.count) comprados" : listView.title
        )
        .toolbar {
            Button {
                showModal.toggle()
            } label: {
                Label("Filtrar", systemImage: "line.3.horizontal.decrease")
            }
            ListDetailMenuView(listView: listView)
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
            activityHelper.setListView(listView)
            activityHelper.startActivity()
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
            Task {
                activityHelper.setListView(nil)
                await activityHelper.endLiveActivity()
            }
        }
    }

    func filterProducts(_ products: [Product]) -> [Product] {
        if searchText.isEmpty {
            return products
        }
        return products.filter { product in
            product.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    NavigationStack {
        ProductListView(
            listView: ListModel(
                title: "Minha Lista", icon: "", color: 1,
                products: [
                    Product(
                        name: "Arroz", quantity: 1, category: "Alimentos",
                        price: 5.0, note: "Arroz branco"),
                    Product(
                        name: "Feijão", quantity: 1, category: "Alimentos",
                        price: 5.0),
                    Product(
                        name: "Macarrão", quantity: 1,
                        category: "Outra categoria", price: 5.0,
                        note: "Macarrão espaguete"),
                ]))
    }
}
