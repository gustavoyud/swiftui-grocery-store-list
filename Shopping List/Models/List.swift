//
//  List.swift
//  Shopping List
//
//  Created by Gustavo Yud on 12/03/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class ListModel: Identifiable {
    // MARK: Lifecycle

    init(title: String, icon: String, color: Int, products: [Product]? = nil) {
        self.title = title
        self.icon = icon
        self.color = color
        self.products = products
    }

    // MARK: Public

    public var id: String = UUID().uuidString

    // MARK: Internal

    var title: String
    var icon: String
    var color: Int
    var isShared: Bool = false
    var createdAt: Date = Date()
    var createdBy: User?
    var isDeleted: Bool = false
    var products: [Product]?

    func toString() -> String {
        return """
        \(self.title)\n        
        -\(self.products?.map { " \($0.name) \($0.quantity.formatted()) \($0.note == nil || (($0.note?.isEmpty) != nil) ? "" : "(\($0.note!))")" }.joined(separator: "\n-") ?? "")
        """.trimmingCharacters(in: .whitespaces)
    }

    func toCodable() -> CodableListModel {
        return CodableListModel(id: self.id, title: self.title, icon: self.icon, color: self.color, isShared: self.isShared, createdAt: self.createdAt, isDeleted: self.isDeleted, products: self.products)
    }
}

struct CodableListModel: Identifiable {
    var id: String
    var title: String
    var icon: String
    var color: Int
    var isShared: Bool
    var createdAt: Date
    var isDeleted: Bool
    var products: [Product]?
}

struct ShoppingList: Identifiable, Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.title)
    }

    let id: String = UUID().uuidString
    let title: String
    let icon: String
    let color: Color
    var isShared: Bool = false
    let createdAt: Date = .init()
    var isDeleted: Bool = false
    var products: [Product]?
}
