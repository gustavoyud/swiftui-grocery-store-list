//
//  CreateCategoryView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 07/04/25.
//

import SwiftUI

struct CreateCategoryView: View {
    /**
        The context of the model.
     */
    @Environment(\.modelContext) private var context
    
    /**
        Dismiss the view.
     */
    @Environment(\.dismiss) var dismiss
    
    /**
        The name of the category
     */
    @State private var name: String = ""
    
    /**
        The icon of the category
     */
    @State private var icon: String = ""

    var body: some View {
        ScrollView {
            VStack {
                TextField("", text: $name, prompt: Text("Digite o nome da categoria"))
                    .foregroundStyle(.gray)
                    .padding(.vertical, 10)
                Rectangle()
                    .frame(height: 0.5, alignment: .bottom)
                    .foregroundColor(Color.gray)
            }

            VStack {
                EmojiTextField(text: $icon, placeholder: "Escolha um emoji")
                    .foregroundStyle(.gray)
                    .padding(.vertical, 10)
                Rectangle()
                    .frame(height: 0.5, alignment: .bottom)
                    .foregroundColor(Color.gray)
            }
        }
        .navigationTitle("Adicionar categoria")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Criar") {
                    let newCategory = Category(name: name, icon: icon)
                    context.insert(newCategory)
                    dismiss()
                }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        CreateCategoryView()
    }
}
