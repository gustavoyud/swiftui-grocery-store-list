//
//  Category.swift
//  Shopping List
//
//  Created by Gustavo Yud on 18/03/25.
//

import Foundation
import SwiftData

@Model
class Category: Identifiable, Hashable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    func toString() -> String {
        return "\(self.icon) \(self.name)"
    }
}


extension Category {
    static var mock: [Category] {
        
        return [
            Category(name: "Frutas", icon: "🍎"),
            Category(name: "Legumes", icon: "🥬"),
            Category(name: "Carne", icon: "🥩"),
            Category(name: "Laticínios", icon: "🥛"),
            Category(name: "Doces", icon: "🍬"),
            Category(name: "Café da Manhã", icon: "☕"),
            Category(name: "Produtos de Limpeza", icon: "🧼"),
            Category(name: "Produtos pessoais", icon: "🧴"),
            Category(name: "Alimentos Perecíveis", icon: "🥕")
        ]
    }
}
