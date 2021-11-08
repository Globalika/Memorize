//
//  EmojiMemoryTheme.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 10.10.2021.
//

import SwiftUI

struct EmojiMemoryTheme: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var emojis: [String]
    var numbersOfPairs: Int
    var rgba: RGBAColor
}
