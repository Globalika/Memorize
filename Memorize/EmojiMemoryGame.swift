//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 08.10.2021.
//

import SwiftUI


class  EmojiMemoryGame : ObservableObject {
    static let carEmojis = ["🚗", "🚕", "🚌", "🚙",
                            "🚎", "🏎", "🚓", "🚑",
                            "🚒", "🚐", "🛻", "🚚",
                            "🚛", "🚜", "🛺", "🚆",
                            "🚖", "🚠", "🚟", "🚃",
                            "🛴","🚲","🛵","🏍"]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String> (numberOfPairsOfCards: 4) { pairIndex in
            carEmojis[pairIndex]
        }
    }
    

    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
