//
//  ImportListViewModel.swift
//  Shopping List
//
//  Created by Gustavo Yud on 27/03/25.
//

import Foundation

struct ImportListViewModel {
    /// The shared service for managing shopping lists.
    var listManager = ListService.shared

    /// The generative AI service used for creating product data from text input.
    var generativeIA = GenerativeAPI()

    /// Imports a list of products from a text description into a specified shopping list.
    /// - Parameters:
    ///   - from: The text description of the list to be imported.
    ///   - to: The shopping list model where the products will be added.
    /// - Throws: An error if the response data is invalid or decoding fails.
    func importList(from: String, to: ListModel) async throws {
        let prompt = """
            Generate a json response based on following list: \(from).

            Use this format: \(Product.schemaMetadata), use the field `quantity` to specify the quantity of each product,
            the field `category` to separate products in category like is in market: first home items, after foods, etc, try to agrupate them in a way that is easy to find each item on super market,
            and the `note` field to rest of the information. 
        
            If a quantity is not specified, use the quantity 1.
            
            If the list contains words like: "g", "l", "kg", "caixa", "pacote", "lata", "bandeja", "saco", etc, use the quantity 1 and put the word in the `note` field. An example: "200g de chocolate ao leite" should be converted to: "Chocolate ao leite" and the note field should contain "200g" and quantity should be 1.
        
            All the information generated should be in Portuguese.
        """.trimmingCharacters(in: .whitespacesAndNewlines)
        let response = await generativeIA.generateText(prompt: prompt)
        let cleanedResponse = response.replacingOccurrences(of: "```json", with: "").replacingOccurrences(of: "```", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let jsonData = cleanedResponse.data(using: .utf8) else {
            throw NSError(domain: "Invalid response data", code: 0, userInfo: nil)
        }
    
        // Decode the JSON data into an array of CodableProduct
        let codableProducts = try JSONDecoder().decode([CodableProduct].self, from: jsonData)
        let products = codableProducts.map { codableProduct in
            Product(
                name: codableProduct.name,
                quantity: codableProduct.quantity,
                category: codableProduct.category,
                price: codableProduct.price,
                note: codableProduct.note
            )
        }
        
        to.products?.append(contentsOf: products)
    }
}
