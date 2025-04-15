//
//  CameraViewModel.swift
//  Shopping List
//
//  Created by Gustavo Yud on 28/03/25.
//

import Foundation
import UIKit

struct CameraViewModel {
    var generativeIA = GenerativeAPI()
    
    func importList(from: UIImage, to: ListModel) async throws {
        let prompt = "Generate a list of products based on all products that appers on image that can be buyed on a market, generate a json response. Use this format: \(Product.schemaMetadata), use the field `quantity` to specify the quantity of each product that appers on image and the `note` fiel to rest of the information. The items should be in Portuguese."
        let response = await generativeIA.generateText(prompt: prompt, image: from)
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
