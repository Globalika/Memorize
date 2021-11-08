//
//  ThemeStore.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 08.11.2021.
//

import SwiftUI

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes: [EmojiMemoryTheme] = [] {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "Theme Store:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode([EmojiMemoryTheme].self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        if themes.isEmpty {
            insertTheme(named: "Halloween", emojis: ["👻", "🎃", "🕷️", "🍬", "💀"], color: .orange)
            insertTheme(named: "Christmas", emojis: ["🎅", "⛪", "🌟", "❄️", "⛄", "🎄", "🎁", "🧦"], color: .blue)
            insertTheme(named: "Transport", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🛺", "🚔", "🚍", "🚘", "🚖", "✈️", "🚝", "🚢", "🚁"], numbersOfPairs: 10, color: .yellow)
            insertTheme(named: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🥏", "🪀", "🏓", "🥊", "🥅", "🥌", "⛸", "🥋"], color: .purple)
            insertTheme(named: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"], color: .green)
        }
        
    }
    
    func theme(at index: Int) -> EmojiMemoryTheme {
        let safeIndex = min(max(0, index), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    @discardableResult
    func insertTheme(at index: Int = 0,
                     named name: String,
                     emojis: [String] = [],
                     numbersOfPairs: Int? = nil,
                     color: Color = .red) -> EmojiMemoryTheme {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = EmojiMemoryTheme(id: unique,
                                     name: name,
                                     emojis: emojis,
                                     numbersOfPairs: numbersOfPairs ?? emojis.count,
                                     color: color)
        let safeIndex = max(min(0, index), themes.count)
        themes.insert(theme, at: safeIndex)
        return themes[safeIndex]
    }
}

extension EmojiMemoryTheme {
    var color: Color {
        get { Color(rgbaColor: rgba) }
        set { rgba = RGBAColor(color: newValue) }
    }
    fileprivate init(id: Int, name: String, emojis: [String], numbersOfPairs: Int, color: Color) {
        self.id = id
        self.name = name
        self.emojis = emojis
        self.numbersOfPairs = numbersOfPairs
        self.rgba = RGBAColor(color: color)
    }
}
