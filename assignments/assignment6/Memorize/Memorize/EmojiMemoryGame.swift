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
    private static var numberOfPairOfCards = 8
    
    init(){
        let randomNumber = Int.random(in: 0...5)
        theme = ThemeStore().choseTheme(themeId: randomNumber, nPairs: EmojiMemoryGame.numberOfPairOfCards)
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    private static func createMemoryGame(theme: ThemeStore.Theme) -> MemoryGame<String> {
   
        return MemoryGame(numberOfPairsOfCards:  numberOfPairOfCards) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    var score: Int {
        model.score
    }
    
    
    func newGame(){
        let randomNumber = Int.random(in: 0...5)
        theme = ThemeStore().choseTheme(themeId: randomNumber, nPairs: EmojiMemoryGame.numberOfPairOfCards)
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

