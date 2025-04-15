//
//  ProductListConfigModalView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 08/04/25.
//

import SwiftUI

struct ProductListConfigModalView: View {
    /**
        The variable that controls the modal view.
     */
    @Binding var showModal: Bool
    
    /**
        The variable that controls the only checked products.
     */
    @Binding var onlyChecked: Bool
    
    /**
        The variable that controls the search text.
     */
    @Binding var searchText: String
    
    /**
        The variable that controls the search state.
     */
    @State var isSearching: Bool = false
    
    var body: some View {
        VStack {
            
            if !isSearching {
                Form {
                    Section(header: Text("Configurações")) {
                        Toggle("Mostrar apenas produtos faltantes", isOn: $onlyChecked)
                    }.listRowBackground(Color("Card"))
                        
                }
                .background(Color("BackgroundColor"))
                .scrollContentBackground(.hidden)
            }

            
            SearchInput(
                searchText: $searchText,
                placeholder: "Digite o nome do produto",
                onSearch: { value in
                    withAnimation(.easeInOut) {
                        isSearching = !value.isEmpty
                    }
                },
                onSubmit: {
                    showModal.toggle()
                },
                enableClearButton: true
            ).padding(.bottom, 20)

        }
        .presentationCornerRadius(25)
        .presentationDetents(!isSearching ? [.height(170), .height(180)] : [.height(100), .height(110)])
        .frame(maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    VStack {}.sheet(isPresented: Binding.constant(true)) {
        ProductListConfigModalView(
            showModal: .constant(true),
            onlyChecked: .constant(false),
            searchText: .constant("")
        )
    }

}
