//
//  ImportListView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 27/03/25.
//

import SwiftUI
import AVFoundation

struct ImportListView: View {
    
    /**
        The list model that will be used to create the products.
     */
    @Environment(\.modelContext) private var context
    
    /**
        Dismiss the view.
     */
    @Environment(\.dismiss) var dismiss
    
    /**
        The list model that will be used to create the products.
     */
    let viewModel = ImportListViewModel()
    
    /**
        The list model that will be used to create the products.
     */
    let item: ListModel
    
    /**
        The list of products that will be shown in the view.
     */
    @State private var listField = ""
    
    /**
        Loading controller
     */
    @State private var loading = false
    
    var body: some View {
        ScrollView {
            TextEditor(text: $listField)
                .padding()
                .font(.title3)
                .foregroundStyle(.gray)
                .background(.gray.opacity(0.2))
                .scrollContentBackground(.hidden)
                .cornerRadius(4)
                .padding()
                .frame(height: 300)
            
            Button {
                loading = true
                Task {
                    do {
                        try await viewModel.importList(from: listField, to: item)
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                    loading = false
                }
            } label: {
                if loading {
                    ProgressView()
                } else {
                    Text("Importar")
                }
            }
            
            
        }.navigationTitle("Importar lista")
    }
}

#Preview {
    NavigationStack {
        ImportListView(item: ListModel(title: "Compras do mês", icon: "paperplane.fill", color: 3))
    }
}
