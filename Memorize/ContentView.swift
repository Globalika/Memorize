//
//  ContentView.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: Array<String> = carEmojis
    @State var emojiCount: Int = 24
    var body: some View {
        VStack {
            Text("Memorize!").font(.title).foregroundColor(.blue)
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(
                    .adaptive(minimum: 65))]) {
                        ForEach(emojis[0..<emojiCount], id : \.self) {
                        emoji in
                        CardViev(content: emoji).aspectRatio(2/3, contentMode:  .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                carTheme
                Spacer()
                faceTheme
                Spacer()
                animalTheme
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
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
}

var carEmojis = ["🚗", "🚕", "🚌", "🚙", "🚎", "🏎", "🚓", "🚑"
                , "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺", "🚆", "🚖", "🚠", "🚟", "🚃","🛴","🚲","🛵","🏍"]
var faceEmojis = ["🤣","😇","😜","🤢","😷","🥴","😵‍💫","🥱","🤥","🙄"]

var animalEmojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"
                  ,"🐷","🐸","🐵","🐔","🦉","🐥","🦆","🦄"]

struct CardViev : View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
       ZStack {
           let shape = RoundedRectangle(cornerRadius: 20)
           
           if isFaceUp {
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth: 4)
               Text(content).font(.largeTitle)
           } else {
               shape.fill()
           }
       }
       .onTapGesture {
           isFaceUp = !isFaceUp
       }
    }
}































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.landscapeLeft)
        ContentView()
            .previewDevice("iPhone 11")
        ContentView()
    }
}
