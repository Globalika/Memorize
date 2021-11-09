//
//  ContentView.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    typealias Card = EmojiMemoryGame.Card
    @ObservedObject var game: EmojiMemoryGame
    @Binding var activeGame: EmojiMemoryGame?
    @Namespace private var dealingNamespace

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    shuffle
                    Spacer()
                    newGame
                }
                .padding(.horizontal)
            }
            VStack {
                deckBody
                score
            }
        }
        .onChange(of: game.cards) { cards in
            if cards.filter({ $0.isMatched }).count == cards.count {
                gameFinishedAlert()
            }
            activeGame = game
        }
        .alert(item: $alertToShow) { alertToShow in
            alertToShow.alert()
        }
        .navigationTitle("\(game.theme.name)")
        .padding()
    }
    
    private func deal(_ card: Card) {
        game.dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: Card) -> Bool {
        !game.dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if (game.cards.filter( { $0.isFaceUp || $0.isMatched }).count > 0 ? false : isUndealt(card)) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card, game: game)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(CardConstants.cardPadding)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                    CardView(card: card, game: game)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale))
                        .zIndex(zIndex(of: card))
            }
        }
        .onTapGesture {
            for card in game.cards {
            withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
        .frame(width: CardConstants.undealtWidth,
               height: CardConstants.undealtHeight)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation{
                game.shuffle()
            }
        }
    }
    
    var newGame: some View {
        Button("New Game") {
            withAnimation{
                game.dealt = []
                game.restart()
            }
        }
    }
    
    var score: some View {
        VStack {
            Text("\(game.score)").foregroundColor(.blue).font(.title)
            Text("\(game.theme.name)").foregroundColor(.blue).font(.subheadline)
        }
    }
    
    @State private var alertToShow: IdentifiableAlert?
    
    func gameFinishedAlert() {
        alertToShow = IdentifiableAlert(id: "Game Has Finished") {
            Alert(title: Text("Congratulations!"),
                  message: Text(
                    """
                    You memorized all the cards.
                    Your final score is \(game.score)
                    """
                  ),
                  primaryButton: .default(Text("Restart")) {
                    withAnimation {
                        game.dealt = []
                        game.restart()
                    }
                  },
                  secondaryButton: .cancel()
            )
        }
    }
    
    private struct CardConstants {
        static let cardPadding: CGFloat = 4
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct IdentifiableAlert: Identifiable {
    var id: String
    var alert: () -> Alert
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = ThemeStore(named: "Preview").theme(at: 0)
        let game = EmojiMemoryGame(theme: theme)
        return EmojiMemoryGameView(game: game, activeGame: .constant(game))
    }
}
