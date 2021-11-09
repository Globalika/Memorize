//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var store = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser(store: store)
        }
    }
}
