//
//  ContentView.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.title).foregroundColor(.blue)
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode:  .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                    }
                }
            }
            .foregroundColor(.red)
                    /*
            Spacer()
            HStack {
                CardView
                //carTheme
                Spacer()
                //faceTheme
                Spacer()
                //animalTheme
            }
            .font(.largeTitle)
            .padding(.horizontal)
                     */
        }
        .padding(.horizontal)
    }
                                /*
    var carTheme: some View {
        VStack{
            Button {
                emojis = carEmojis.shuffled()
                emojiCount = 24
            } label: {
                Image(systemName: "car")
            }
            Text("cars").foregroundColor(.blue).font(.subheadline)
        }
    }
                                
    var faceTheme: some View {
        VStack{
            Button {
                emojis = faceEmojis.shuffled()
                emojiCount = 10
            } label: {
                Image(systemName: "face.smiling")
            }
            Text("faces").foregroundColor(.blue).font(.subheadline)
        }
    }
    var animalTheme: some View {
        VStack{
            Button {
                emojis = animalEmojis.shuffled()
                emojiCount = 20
            } label: {
                Image(systemName: "hare")
            }
            Text("animals").foregroundColor(.blue).font(.subheadline)
        }
    }
                                 */
}

var carEmojis = ["🚗", "🚕", "🚌", "🚙", "🚎", "🏎", "🚓", "🚑"
                , "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺", "🚆", "🚖", "🚠", "🚟", "🚃","🛴","🚲","🛵","🏍"]
var faceEmojis = ["🤣","😇","😜","🤢","😷","🥴","😵‍💫","🥱","🤥","🙄"]

var animalEmojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"
                  ,"🐷","🐸","🐵","🐔","🦉","🐥","🦆","🦄"]

struct CardView : View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
       ZStack {
           let shape = RoundedRectangle(cornerRadius: 20)
           
           if card.isFaceUp {
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth: 4)
               Text(card.content).font(.largeTitle)
           } else if card.isMatched {
               shape.opacity(0)
           } else {
               shape.fill()
           }
       }
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
    }
}
