//
//  EmojiMemoryGame.swift
//  Memorize
//
//  codes from CS193p Instructor, modified by Chenqin Zhang on 2024/03/19
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    private(set) var theme: ThemeStore.Theme
//    private static var numberOfPairOfCards = 8
    var themeChooser: ThemeChooser
    
    init(themeID: UUID, themeChooser: ThemeChooser){
        self.themeChooser = themeChooser
        theme = self.themeChooser.choseTheme(by: themeID)
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    private static func createMemoryGame(theme: ThemeStore.Theme) -> MemoryGame<String> {
   
        return MemoryGame(numberOfPairsOfCards:  theme.nPairs) { pairIndex in
            if theme.emojis.count > pairIndex {
                return String(theme.emojis[theme.emojis.index(theme.emojis.startIndex, offsetBy: pairIndex)])
            } else {
                return "⁉️"
            }
        }
    }
    
    var score: Int {
        model.score
    }
    
    
    func newGame(themeID: UUID){
        theme = themeChooser.choseTheme(by: themeID)
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}

