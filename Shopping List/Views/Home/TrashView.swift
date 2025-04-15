//
//  TrashView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 12/03/25.
//

import SwiftData
import SwiftUI

struct TrashView: View {
    /// The shared service for managing shopping lists.
    @ObservedObject var listManager = ListService.shared

    /// The environment context used for managing the model data.
    @Environment(\.modelContext) private var context

    /// A query to fetch shopping lists that are marked as deleted, sorted by title.
    @Query(
        filter: #Predicate<ListModel> { item in
            item.isDeleted == true
        },
        sort: \ListModel.title) private var list: [ListModel]
    

    var body: some View {
        List {
            if list.isEmpty {
                VStack {
                    Text("Não encontramos resultados")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Nenhuma lista criada")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(
                            maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }

            ForEach(list) { item in
                Section {
                    ListItemView(item: item, isTrash: true).padding(.horizontal, 12)
                        .listRowBackground(Color.red.opacity(0.3))
                        .listRowSeparator(.hidden)
                }.listSectionSpacing(10)
            }
        }
        .scrollContentBackground(.hidden)
        .navigationBarTitle("Lixo")
    }
}

#Preview {
    TrashView()
}
