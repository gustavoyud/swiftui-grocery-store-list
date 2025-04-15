//
//  User.swift
//  Shopping List
//
//  Created by Gustavo Yud on 10/04/25.
//

import Foundation
import SwiftData
import UIKit

@Model
class User: Identifiable, Hashable {
    var id: String
    var createdAt: Date = Date()
    var name: String
    var nickname: String
    var email: String
    var photo: Data?
    var password: String = ""
    var isLoggedIn: Bool = false
    
    init(name: String, nickname: String, email: String, photo: Data? = nil) {
        self.id = UUID().uuidString
        self.nickname = nickname
        self.name = name
        self.email = email
        self.photo = photo
    }
    
    func nameToString() -> String {
        return "\(self.name) \(self.nickname)"
    }
}
