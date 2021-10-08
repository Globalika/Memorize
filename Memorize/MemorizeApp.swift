//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
