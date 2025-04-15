//
//  ShoppingListView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 11/03/25.
//

import SwiftData
import SwiftUI

struct ShoppingListView: View {
    /// The shared service for managing shopping lists.
    @ObservedObject var listManager = ListService.shared

    /// The environment context used for managing the model data.
    @Environment(\.modelContext) private var context

    /// A query to fetch shopping lists that are not deleted, sorted by title.
    @Query(
        filter: #Predicate<ListModel> { item in
            item.isDeleted == false
        },
        sort: \ListModel.title) private var list: [ListModel]
    
    
    var body: some View {
        List {
            if list.isEmpty {
                VStack (alignment: .center) {
                    Text("Não encontramos resultados")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Nenhuma lista criada")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            ForEach(list) { item in
                Section {
                    ListItemView(item: item)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationBarTitle("Listas")
        .toolbar {
            NavigationLink {
                AddListView()
            } label: {
                Text("Adicionar lista")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShoppingListView()
            .modelContainer(for: ListModel.self, inMemory: true)
    }
}
