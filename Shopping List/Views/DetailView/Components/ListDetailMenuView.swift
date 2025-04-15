//
//  ListDetailMenuView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 03/04/25.
//

import SwiftData
import SwiftUI

struct ListDetailMenuView: View {
    /**
        The list view that contains the products.
     */
    var listView: ListModel
    
    /**
        A boolean to show only checked
     */
    var isAnySelected: Bool {
        listView.products?.contains(where: { $0.isChecked == true }) ?? false
    }

    var body: some View {
        Menu {
            NavigationLink {
                AddProductView(item: listView)
            } label: {
                Label("Adicionar produto", systemImage: "plus")
            }
            NavigationLink {
                AddListView(shoppingList: listView)
            } label: {
                Label("Editar lista", systemImage: "pencil")
            }
            NavigationLink {
                CameraView(listModel: listView)
            } label: {
                Label("Adicionar por foto", systemImage: "camera")
            }
            NavigationLink {
                ImportListView(item: listView)
            } label: {
                Label("Importar", systemImage: "arrow.down.circle.dotted")
            }
            ShareLink(item: listView.toString()) {
                Label("Compartilhar", systemImage: "square.and.arrow.up")
            }

            Divider()

            Button {
                listView.products?.forEach { item in
                    item.isChecked = true
                }
            } label: {
                Text("Selecionar todos")
            }

            if isAnySelected {
                Button {
                    listView.products?.forEach { item in
                        item.isChecked = false
                    }
                } label: {
                    Text("Desmarcar todos")
                }

                Divider()

                Button(role: .destructive) {
                    listView.products?.removeAll(where: {
                        $0.isChecked == true
                    })
                } label: {
                    Label("Apagar Selecionados", systemImage: "trash")
                }
            }

        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
        }
    }
}

#Preview {
    NavigationStack {
        ListDetailMenuView(
            listView: ListModel(title: "Compras do mês", icon: "paperplane.fill", color: 3)
        )
    }
}
