//
//  CategoryListView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 18/03/25.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    /**
        The list of categories to display. This is a mock data for now.
     */
    let categories = Category.mock
    
    /**
        The name of the category
     */
    let name: String
    
    /**
        The closure to be called when a category is selected.
     */
    let onSelect: (String) -> Void

    /**
        The selected category
     */
    @State private var singleSelection: UUID?
    
    /**
        The selected category
     */
    @Environment(\.dismiss) var dismiss
    
    /**
        The list of categories
     */
    @Query(sort: \Category.name) var list: [Category]
    
    var body: some View {
        Text(name)
            .font(.subheadline)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .foregroundColor(.secondary)
        
        
        HStack {
            Text("Adicionar Categoria")
                .font(.title)
                .bold()
            Spacer()
            NavigationLink {
                CreateCategoryView()
            } label: {
                Text("Criar")
            }
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        List {
            ForEach(list + categories) { category in
                Button {
                    onSelect(category.toString())
                    dismiss()
                } label: {
                    HStack {
                        Text(category.icon)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(.accent)
                            .cornerRadius(20)
                        
                        Text(category.name).bold()
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        CategoryListView(name: "Frutas", onSelect: { _ in })
    }
    
}
