//
//  ContentView.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

struct ContentView: View {
    var emojis: [String] = ["🚗", "🚕", "🚌", "🚙", "🚎", "🏎", "🚓", "🚑"
                            , "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺", "🚆", "🚖", "🚠", "🚟", "🚃","🛴","🚲","🛵","🏍"]
    @State var emojiCount : Int = 24
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(
                    .adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id : \.self) { emoji in
                        CardViev(content: emoji).aspectRatio(2/3, contentMode:  .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                add
                Spacer()
                remove
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    
    
}

struct CardViev : View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
       ZStack {
           let shape = RoundedRectangle(cornerRadius: 20)
           
           if isFaceUp {
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth: 8)
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
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.landscapeLeft)
    }
}
