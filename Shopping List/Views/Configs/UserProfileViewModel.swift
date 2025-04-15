//
//  UserProfileViewModel.swift
//  Shopping List
//
//  Created by Gustavo Yud on 10/04/25.
//

import Foundation
import SwiftData

struct UserProfileViewModel {    
    /**
        Save the user profile.
     */
    func save(user: User?, name: String, nickname: String, email: String, data: Data?, context: ModelContext) {
        if user != nil {
            user?.name = name
            user?.nickname = nickname
            user?.email = email
            if let data = data {
                user?.photo = data
            }
        } else {
            let user = User(name: name, nickname: nickname, email: email, photo: data)
            UserDefaultsHelper.save(value: user.id, key: "user_pk")
            context.insert(user)
        }
    }
}
