//
//  SearchInput.swift
//  Shopping List
//
//  Created by Gustavo Yud on 02/04/25.
//

import SwiftUI

struct SearchInput: View {
    /// The binding for the search text entered by the user.
    @Binding var searchText: String

    /// The state to manage the focus of the search field.
    @FocusState private var focusedField: String?

    /// The placeholder text displayed in the search field.
    let placeholder: String

    /// A closure that is called whenever the search text changes.
    let onSearch: (String) -> Void

    /// A closure that is called when the user submits the search.
    let onSubmit: () -> Void

    /// A flag to enable or disable the clear button in the search field.
    let enableClearButton: Bool

    /// Initializes the `SearchInput` view with the required parameters.
    /// - Parameters:
    ///   - searchText: A binding to the search text.
    ///   - placeholder: The placeholder text for the search field.
    ///   - onSearch: A closure to handle search text changes.
    ///   - onSubmit: A closure to handle search submission.
    ///   - enableClearButton: A flag to enable the clear button (default is `false`).
    init(searchText: Binding<String>, placeholder: String, onSearch: @escaping (String) -> Void, onSubmit: @escaping () -> Void, enableClearButton: Bool = false) {
        self._searchText = searchText
        self.placeholder = placeholder
        self.onSearch = onSearch
        self.onSubmit = onSubmit
        self.enableClearButton = enableClearButton
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $searchText)
                    .onChange(of: searchText) { text in
                        onSearch(text)
                    }
                    .onSubmit {
                        onSubmit()
                    }
                    .focused($focusedField, equals: "search")
                    .onAppear {
                        if enableClearButton {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    }
            }
            .padding(14)
            .background(Color.gray.opacity(0.12))
            .cornerRadius(14)
            .padding(.horizontal)
            .onAppear {
                focusedField = "search"
            }
        }
    }
}

#Preview {
    SearchInput(searchText: .constant(""), placeholder: "Digite o nome do produto", onSearch: { _ in }, onSubmit: {  }, enableClearButton: true)
}
