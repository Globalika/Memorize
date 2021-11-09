//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 08.10.2021.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    @Published var dealt = Set<Int>()
    var theme: EmojiMemoryTheme
    
    private static func createMemoryGame(theme: EmojiMemoryTheme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numbersOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    init(theme: EmojiMemoryTheme){
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    //MARK: - Access to the model
    
    var score: Int {
        model.score
    }
    
    var cards: Array<Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
