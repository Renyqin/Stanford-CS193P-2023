//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Chenqin zhang on 2024/3/18.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
        
    }
    
}
