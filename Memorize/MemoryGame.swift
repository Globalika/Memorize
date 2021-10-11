//
//  MemoryGame.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 08.10.2021.
//

import Foundation

struct MemoryGame<CardContect> where CardContect: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var score = 0
    private var seenCards = Set<Int>()
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
            {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                else {
                    if seenCards.contains(cards[chosenIndex].id) {
                        score -= 1
                    }
                    if seenCards.contains(cards[potentialMatchIndex].id) {
                        score -= 1
                    }
                    seenCards.insert(cards[chosenIndex].id)
                    seenCards.insert(cards[potentialMatchIndex].id)
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            else
            {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContect) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card : Identifiable {
        var isFaceUp: Bool = false
        var isMatched:  Bool = false
        var content: CardContect
        var id: Int
    }
}
