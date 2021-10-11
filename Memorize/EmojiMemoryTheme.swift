//
//  EmojiMemoryTheme.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 10.10.2021.
//

import Foundation
import SwiftUI

struct EmojiMemoryTheme : Identifiable {
    var id: String { name }
    let name: String
    let numbersOfPairs: Int
    let emojis: [String]
    let color: Color
    init(name: String, numbersOfPairs: Int, emojis: [String], color: Color) {
        self.name = name
        self.numbersOfPairs = numbersOfPairs
        self.emojis = emojis
        self.color = color
    }
    static let themes: [EmojiMemoryTheme] = [
        EmojiMemoryTheme(name: "cars", numbersOfPairs: 8,
                         emojis: ["🚗", "🚕", "🚌", "🚙","🚎", "🏎", "🚓", "🚑",
                                 "🚒", "🚐", "🛻", "🚚","🚛", "🚜", "🛺", "🚆",
                                  "🚖", "🚠", "🚟", "🚃","🛴","🚲","🛵","🏍"], color: .orange),
        EmojiMemoryTheme(name: "faces", numbersOfPairs: 5,
                         emojis: ["🤣","😇","😜","🤢","😷",
                                  "🥴","😵‍💫","🥱","🤥","🙄"] , color: .red),
        EmojiMemoryTheme(name: "animals", numbersOfPairs: 6,
                         emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼",
                                  "🐨","🐯","🦁","🐮" ,"🐷","🐸","🐵","🐔",
                                  "🦉","🐥","🦆","🦄"], color: .blue),
        EmojiMemoryTheme(name: "cars", numbersOfPairs: 5,
                         emojis: ["🍏","🍎","🍊","🍐","🍓","🍇",
                                  "🥝","🥥","🍌","🍋","🍑","🥭"], color: .yellow),
        EmojiMemoryTheme(name: "gadgets", numbersOfPairs: 4,
                         emojis: ["⌚️","📱","💻","🖨","🖥",
                                  "🖱","📷","📺","🎥","⌨️"], color: .green),
        EmojiMemoryTheme(name: "sport", numbersOfPairs: 5,
                         emojis: ["⚽️","🪃","🏓","🥊","🎾","🏈",
                                  "🥋","🛼","⛸","🥌","🛹","🏀"], color: .purple),
    ]
}
