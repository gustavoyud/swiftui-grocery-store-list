//
//  ListItemView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 12/03/25.
//

import SwiftData
import SwiftUI

struct ListItemView: View {
    /// The environment context used for managing the model data.
    @Environment(\.modelContext) private var context
    
    /// The shopping list item to be displayed.
    let item: ListModel
    
    /// The view model for managing the addition of shopping lists.
    var viewModel = AddListViewModel()
    
    /// A flag indicating whether the item is in the trash.
    var isTrash = false
    
    var body: some View {
        let selectedItems = item.products?.filter { $0.isChecked == true } ?? []
        HStack {
            Image(systemName: item.icon)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(colorList[item.color])
                .cornerRadius(20)
            
            Text(item.title)
                .font(.title2)
                .foregroundStyle(.text)
            
            Spacer()
            
            if item.isShared {
                ZStack {
                    UserImage(image: .user1)
                    UserImage(image: .user1)
                        .offset(x: -20)
                }
            }
            
            Text("\(selectedItems.count)/\(item.products?.count ?? 0)")
        }
        .background(
            NavigationLink("", destination: ProductListView(listView: item))
                .opacity(0)
        )
        .padding(.vertical)
        .swipeActions(allowsFullSwipe: false) {
            Button(role: .destructive) {
                if (isTrash) {
                    context.delete(item)
                } else {
                    item.isDeleted = true
                }
            } label: {
                Label("Deletar", systemImage: "trash.fill")
            }
            
            if !isTrash {
                ShareLink(item: item.toString()) {
                    Label("Compartilhar", systemImage: "square.and.arrow.up")
                }.tint(.blue)
                
                NavigationLink {
                    AddListView(shoppingList: item)
                } label: {
                    Label("Editar", systemImage: "pencil")
                }.tint(.listColor1)
                
                NavigationLink {
                    ImportListView(item: item)
                } label: {
                    Label("Importar", systemImage: "arrow.down.circle.dotted")
                }
                .tint(.gray)
            } else {
                Button {
                    item.isDeleted = false
                } label: {
                    Label("Recuperar", systemImage: "arrow.trianglehead.counterclockwise")
                }.tint(.green)
            }
        }
    }
}

struct UserImage: View {
    var image: ImageResource
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 30, height: 30)
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .shadow(radius: 2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        List {
            Section {
                ListItemView(item: ListModel(title: "Compras do mês", icon: "paperplane.fill", color: 1), isTrash: true)
            }
            
            ListItemView(item: ListModel(title: "Compras do mês", icon: "paperplane.fill", color: 3), isTrash: false)
        }.listStyle(.plain)
        .scrollContentBackground(.hidden)
            .modelContainer(for: ListModel.self, inMemory: true)
    }
}
