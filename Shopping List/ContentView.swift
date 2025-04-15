//
//  ContentView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 11/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ShoppingListView()
            }
            .tabItem {
                Label {
                    Text("Listas")
                } icon: {
                    Image(systemName: "checklist")
                }
            }
            NavigationStack {
                TrashView()
            }
            .tabItem {
                Label {
                    Text("Lixo")
                } icon: {
                    Image(systemName: "trash")
                }
            }
            NavigationStack {
                ConfigsView()
            }
            .tabItem {
                Label {
                    Text("Configurações")
                } icon: {
                    Image(systemName: "person.crop.circle.fill")
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    ContentView()
}
