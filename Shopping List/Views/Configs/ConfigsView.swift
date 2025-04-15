//
//  ConfigsView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 11/03/25.
//

import SwiftUI
import SwiftData

struct ConfigsView: View {
    
    /**
     Dark mode property.
     */
    @State private var isDarkMode: Bool = false
    
    /**
     The `@Query` property wrapper is used to fetch data from the SwiftData model.
     */
    @Query var users: [User]
    
    /**
     Computed property to get the first user from the list of users.
     */
    var user: User? { users.filter { $0.id == UserDefaultsHelper.get(for: "user_pk")}.first }
    
    /**
     Appearance selection.
     */
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0
    
    var body: some View {
        Form {
            NavigationLink {
                UserProfileView(user: user)
            } label: {
                HStack {
                    Image(uiImage: UIImage(data: user?.photo ?? Data()) ?? UIImage(resource: .placeholder))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                    if let user {
                        VStack(alignment: .leading) {
                            Text(user.nameToString())
                                .font(.title3)
                                .foregroundStyle(.text)
                                .bold()
                            Text(user.email)
                                .foregroundStyle(.text)
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text("Não tem usuário?")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.text)
                            
                            Text("Crie sua conta agora")
                                .foregroundStyle(.text)
                        }
                    }
                }
            }
            
            Section(header: Text("Tema")) {
                Picker(selection: $appearanceSelection) {
                    Text("Sistema")
                        .tag(0)
                    Text("Claro")
                        .tag(1)
                    Text("Escuro")
                        .tag(2)
                } label: {
                  Text("Selecione a aparência")
                }
                .pickerStyle(.navigationLink)
            }
        }
            .navigationTitle("Configurações")
    }
}

#Preview {
    NavigationStack {
        ConfigsView()
    }

}
