//
//  ProductViewModel.swift
//  Shopping List
//
//  Created by Gustavo Yud on 03/04/25.
//

import Foundation

struct AddProductViewModel {
    /**
        The view model for the import list. This is used to import a list of products from a string.
     */
    let importListViewModel = ImportListViewModel()
    
    /**
        The view model for the product list. This is used to manage the product list.
     
        - Parameter list: The list of products to be managed.
        - Parameter model: The model of the list to be managed.
        - Parameter enableClassification: A boolean to enable or disable classification.
     
        - Throws: An error if the import fails.
        - Returns: A boolean indicating whether the import was successful.
     */
    func createProducts(list: Set<Product>, model: ListModel, enableClassification: Bool) async throws {
        let selectedProducts = Array(list)
        
        if enableClassification {
            let string = selectedProducts.map { "\($0.name)" }.joined(separator: "\n")
            try await importListViewModel.importList(from: string, to: model)
            return;
        }
        
        model.products?.append(contentsOf: selectedProducts)
    }
}
