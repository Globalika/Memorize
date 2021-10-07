//
//  ContentView.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 07.10.2021.
//

import SwiftUI

struct ContentView: View {
    var emojis: [String] = ["🚗", "🚕", "🚌", "🚙", "🚎", "🏎", "🚓", "🚑"
                            , "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛺", "🚆", "🚖", "🚠", "🚟", "🚃"]
    @State var emojiCount : Int = 4
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id : \.self) { emoji in
                    CardViev(content: emoji)
                }
            }
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
        .foregroundColor(.red)
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
               shape.stroke(lineWidth: 3)
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
        ContentView()
            .preferredColorScheme(.light)
    }
}
