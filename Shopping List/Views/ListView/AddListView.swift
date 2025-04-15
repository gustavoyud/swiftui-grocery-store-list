//
//  AddListView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 12/03/25.
//

import SwiftUI

struct AddListView: View {
    /// The view model for managing the addition or update of shopping lists.
    let viewModel = AddListViewModel()

    /// The shopping list being edited, or `nil` if creating a new list.
    let shoppingList: ListModel?

    /// The environment context used for managing the model data.
    @Environment(\.modelContext) private var context

    /// The environment variable for dismissing the view.
    @Environment(\.dismiss) var dismiss

    /// The state for managing the loading indicator.
    @State private var loading = false

    /// The state for the shopping list's name.
    @State private var listName: String

    /// The state for the selected color of the shopping list.
    @State private var colorSelected: Int

    /// The state for the selected icon of the shopping list.
    @State private var iconSelected: String
    
    /// A list of available icons for the shopping list.
    var iconList: [String] = [
        "text.page.fill",
        "basket",
        "tag.fill",
        "shippingbox.fill",
        "heart.fill",
        "car",
        "gamecontroller.fill",
        "camera.macro",
        "sunglasses.fill",
        "cross.case.fill",
        "graduationcap.fill",
        "wineglass",
        "pawprint.fill",
        "paperclip",
        "soccerball.inverse",
        "book.fill",
    ]
    
    /// Initializes the `AddListView` with the required parameters.
    /// - Parameter shoppingList: The shopping list to edit, or `nil` to create a new list.
    init(shoppingList: ListModel? = nil) {
        self.shoppingList = shoppingList
        _colorSelected = State(initialValue: shoppingList?.color ?? 1)
        _listName = State(initialValue: shoppingList?.title ?? "")
        _iconSelected = State(initialValue: shoppingList?.icon ?? "text.page.fill")
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    TextField("Digite o nome da sua lista", text: $listName)
                    Button {
                        Task {
                            loading = true
                            let text = await viewModel.generateTitle(shoppingList)
                            loading = false
                            listName = text
                        }
                    } label: {
                        if loading {
                            ProgressView()
                        } else {
                            Image(systemName: "sparkles")
                                .foregroundColor(.gray)
                        }
                    }.disabled(loading)
                }
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
                
                if shoppingList != nil {
                    Text("O texto será gerado com base na lista de produtos")
                        .foregroundStyle(.gray)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
                .padding(.horizontal)
                .padding(.bottom, 24)

            VStack {
                Text("Cor")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .bold()
                
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 60, maximum: 80))],
                    spacing: 20)
                {
                    ForEach(0 ..< colorList.count, id: \.self) { index in
                        let color = colorList[index]
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                colorSelected = index
                            }
                        } label: {
                            Circle()
                                .frame(width: 42, height: 42)
                                .foregroundColor(color)
                                .padding(colorSelected == index ? 5 : 0)
                                .overlay {
                                    Circle().stroke(
                                        color,
                                        lineWidth: colorSelected == index
                                            ? 3 : 0)
                                }
                        }
                    }
                }
                
            }.padding(.horizontal)
            VStack {
                Text("Ícone")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .bold()
                
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 60, maximum: 80))],
                    spacing: 20)
                {
                    ForEach(iconList, id: \.self) { icon in
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                iconSelected = icon
                            }
                        } label: {
                            Circle()
                                .frame(width: 42, height: 42)
                                .foregroundColor(colorList[colorSelected])
                                .padding(iconSelected == icon ? 5 : 0)
                                .overlay {
                                    Circle().stroke(
                                        colorList[colorSelected],
                                        lineWidth: iconSelected == icon ? 3 : 0)
                                    
                                    Image(systemName: icon)
                                }
                            
                        }.foregroundColor(.white)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
        }.toolbar {
            Button {
                viewModel.createOrUpdateList(
                    listName: listName,
                    iconSelected: iconSelected,
                    colorSelected: colorSelected,
                    list: shoppingList)
                { item in
                    if item != nil {
                        context.insert(item!)
                    }
                    dismiss()
                }
                
            } label: {
                Text("Concluir")
            }
        }
        .navigationTitle(shoppingList?.title ?? "Nova lista")
    }
}

#Preview {
    NavigationStack {
        AddListView(shoppingList: ListModel(title: "MinhaLista", icon: "", color: 1))
    }
}
