//
//  Shopping_ListApp.swift
//  Shopping List
//
//  Created by Gustavo Yud on 11/03/25.
//

import SwiftUI
import SwiftData

@main
struct Shopping_ListApp: App {
    /**
        Appearance selection.
     */
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0

    /**
        The context of the model.
     */
    var appearanceSwitch: ColorScheme? {
        if appearanceSelection == 1 {
            return .light
        }
        else if appearanceSelection == 2 {
            return .dark
        }
        else {
            return .none
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appearanceSwitch)
        }
        .modelContainer(for: ListModel.self)
    }
}
