//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 08.10.2021.
//

import SwiftUI


class  EmojiMemoryGame : ObservableObject {
    


    @Published private var model: MemoryGame<String>
    private(set) var theme: EmojiMemoryTheme
    
    
    init(theme: EmojiMemoryTheme? = nil){
        self.theme = theme ?? EmojiMemoryTheme.themes.randomElement()!
        let emoji = self.theme.emojis.shuffled()
        self.model = MemoryGame<String>(numberOfPairsOfCards: self.theme.numbersOfPairs) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    //MARK: - Access to the model
    
    var score: Int {
        model.score
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restart() {
        
        self.theme = EmojiMemoryTheme.themes.randomElement()!
        let emoji = self.theme.emojis.shuffled()
        self.model = MemoryGame<String>(numberOfPairsOfCards: self.theme.numbersOfPairs) { pairIndex in
            emoji[pairIndex]
        }
    }
}
