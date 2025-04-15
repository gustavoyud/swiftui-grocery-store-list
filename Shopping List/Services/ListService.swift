//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Gustavo Yud on 20/02/25.
//

import Foundation

class ListService: ObservableObject {
    static let shared = ListService()
    
    @Published var list: [ShoppingList]?
    @Published var deletedList: [ShoppingList]?
    
    private init() {
        self.list = []
        self.deletedList = []
    }
    
    func setList(_ list: ShoppingList) {
        self.list?.append(list)
    }
    
    func removeFromListById(_ id: String) {
        if let item = self.list?.first(where: { $0.id == id }) {
            self.deletedList?.append(item)
            self.list?.removeAll { $0.id == id }
        }
    }
    
    func updateProductInListById(_ id: String, _ newProduct: Product) {
        if let index = self.list?.firstIndex(where: { $0.id == id }) {
            self.list?[index].products?.append(newProduct)
        }
    }

}
