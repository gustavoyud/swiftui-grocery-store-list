//
//  ListItem.swift
//  Shopping List
//
//  Created by Gustavo Yud on 12/03/25.
//

import Foundation
import SwiftData

@Model
class Product: Identifiable, Hashable {
    var id: String
    var name: String
    var quantity: Int
    var category: String
    var isChecked: Bool = false
    var price: Double?
    var note: String?
    var directCategory: Category?
    
    init(name: String, quantity: Int, category: String, price: Double? = nil, note: String? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.quantity = quantity
        self.category = category
        self.price = price
        self.note = note
    }
}

class CodableProduct: Codable {
    var name: String
    var quantity: Int
    var category: String
    var price: Double?
    var note: String?
}

extension Product {
    static var mock: [Product] {
        return [
            // Frutas
            Product(name: "Maçã", quantity: 1, category: "Frutas", price: 5.0),
            Product(name: "Banana", quantity: 1, category: "Frutas", price: 3.0),
            Product(name: "Laranja", quantity: 1, category: "Frutas", price: 4.0),
            Product(name: "Uva", quantity: 1, category: "Frutas", price: 7.0),
            Product(name: "Morango", quantity: 1, category: "Frutas", price: 3.0),
            Product(name: "Melancia", quantity: 1, category: "Frutas", price: 10.0),
            Product(name: "Pera", quantity: 1, category: "Frutas", price: 3.0),
            Product(name: "Abacaxi", quantity: 1, category: "Frutas", price: 5.0),
            Product(name: "Manga", quantity: 1, category: "Frutas", price: 4.0),
            Product(name: "Kiwi", quantity: 1, category: "Frutas", price: 3.0),
            
            // Legumes
            Product(name: "Alface", quantity: 1, category: "Legumes", price: 2.0),
            Product(name: "Tomate", quantity: 1, category: "Legumes", price: 4.0),
            Product(name: "Cenoura", quantity: 1, category: "Legumes", price: 2.0),
            Product(name: "Batata", quantity: 1, category: "Legumes", price: 3.0),
            
            // Carne
            Product(name: "Picanha", quantity: 1, category: "Carne", price: 50.0),
            Product(name: "Frango", quantity: 1, category: "Carne", price: 15.0),
            Product(name: "Carne Moída", quantity: 1, category: "Carne", price: 20.0),
            
            // Laticínios
            Product(name: "Leite", quantity: 1, category: "Laticínios", price: 3.0),
            Product(name: "Ovos", quantity: 1, category: "Laticínios", price: 6.0),
            Product(name: "Queijo", quantity: 1, category: "Laticínios", price: 10.0),
            Product(name: "Iogurte", quantity: 1, category: "Laticínios", price: 8.0),
            Product(name: "Manteiga", quantity: 1, category: "Laticínios", price: 5.0),
            Product(name: "Requeijão", quantity: 1, category: "Laticínios", price: 7.0),
            Product(name: "Creme de Leite", quantity: 1, category: "Laticínios", price: 3.0),
            Product(name: "Leite Condensado", quantity: 1, category: "Laticínios", price: 4.0),
            Product(name: "Queijo Ralado", quantity: 1, category: "Laticínios", price: 6.0),
            Product(name: "Leite em Pó", quantity: 1, category: "Laticínios", price: 5.0),
            Product(name: "Iogurte Grego", quantity: 1, category: "Laticínios", price: 10.0),
            Product(name: "Iogurte Natural", quantity: 1, category: "Laticínios", price: 5.0),
            
            // Doces
            Product(name: "Chocolate", quantity: 1, category: "Doces", price: 4.0),
            Product(name: "Biscoito", quantity: 1, category: "Doces", price: 3.0),
            Product(name: "Sorvete", quantity: 1, category: "Doces", price: 10.0),
            
            // Café da Manhã
            Product(name: "Café", quantity: 1, category: "Café da Manhã", price: 7.0),
            Product(name: "Pão", quantity: 1, category: "Café da Manhã", price: 3.0),
            
            // Produtos de Limpeza
            Product(name: "Detergente", quantity: 1, category: "Produtos de Limpeza", price: 2.0),
            Product(name: "Sabão em Pó", quantity: 1, category: "Produtos de Limpeza", price: 8.0),
            Product(name: "Desinfetante", quantity: 1, category: "Produtos de Limpeza", price: 5.0),
            Product(name: "Veja", quantity: 1, category: "Produtos de Limpeza", price: 4.0),
            Product(name: "Água Sanitária", quantity: 1, category: "Produtos de Limpeza", price: 3.0),
            
            // Produtos Pessoais
            Product(name: "Sabonete", quantity: 1, category: "Produtos pessoais", price: 1.0),
            Product(name: "Shampoo", quantity: 1, category: "Produtos pessoais", price: 5.0),
            Product(name: "Pasta de Dente", quantity: 1, category: "Produtos pessoais", price: 3.0),
            
            // Alimentos Perecíveis
            Product(name: "Cenoura", quantity: 1, category: "Alimentos Perecíveis", price: 2.0),
            Product(name: "Alface", quantity: 1, category: "Alimentos Perecíveis", price: 2.0),
            Product(name: "Tomate", quantity: 1, category: "Alimentos Perecíveis", price: 4.0)
        ]
    }
}
