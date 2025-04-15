//
//  AddListViewModel.swift
//  Shopping List
//
//  Created by Gustavo Yud on 13/03/25.
//

import Foundation

struct AddListViewModel {
    /// The shared service for managing shopping lists.
    let listManager = ListService.shared

    /// The shared generative AI service for generating text-based suggestions.
    let gemini = GenerativeAPI.shared
    /// Generates a title for a shopping list.
    /// - Parameter listModel: An optional shopping list model to base the title on.
    /// - Returns: A generated title as a `String`.
    func generateTitle(_ listModel: ListModel? = nil) async -> String {
        let prompt: String
        if listModel != nil {
            prompt = """
            Generate a name for a shopping list in Portuguese in up to 5 words, the answer must be plain text. For example: "Lista de compras para o churrasco do final de semana".
            The name should be related to the following list: \(listModel!.toString())
        """.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            prompt = """
            Generate a name for a shopping list in Portuguese in up to 5 words, the answer must be plain text. For example: "Lista de compras para o churrasco do final de semana".
            The name should be creative and related to a shopping list.
        """.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return await gemini.generateText(prompt: prompt).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Creates or updates a shopping list.
    /// - Parameters:
    ///   - listName: The name of the shopping list.
    ///   - iconSelected: The selected icon for the shopping list.
    ///   - colorSelected: The selected color for the shopping list.
    ///   - list: An optional existing shopping list to update.
    ///   - onFinished: A closure called when the operation is complete.
    func createOrUpdateList(
        listName: String,
        iconSelected: String,
        colorSelected: Int,
        list: ListModel?,
        onFinished: @escaping (ListModel?) -> Void
    ) {
        if listName != "" {
            if list == nil {
                let item = ListModel(title: listName, icon: iconSelected, color: colorSelected)
                onFinished(item)
            } else {
                list?.title = listName
                list?.color = colorSelected
                list?.icon = iconSelected
                onFinished(nil)
            }
        }
    }
}
