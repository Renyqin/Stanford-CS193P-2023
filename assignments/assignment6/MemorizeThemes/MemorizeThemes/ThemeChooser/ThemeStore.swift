//
//  ThemeStore.swift
//  Memorize
//
//  Created by Chenqin zhang on 2024/3/19.
//

import Foundation
import SwiftUI

struct ThemeStore {
    
    
    static let nPairs = 12
    static var builtins:[Theme] {[
        Theme(name: "Halloween", emojis:
                                ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"].shuffled(),
                             nPairs: nPairs, Color: .orange),
        Theme(name: "Vehicle", emojis:
                                ["🚗", "🚖", "⛴️", "🚁", "🚚", "🚂", "🚀", "🚌", "🚑", "🚔", "🚜", "🚄"].shuffled(),
                             nPairs: nPairs, Color: .blue),
        Theme(name: "Drink", emojis:
                                ["🥂", "🍵", "🥛", "🧋", "🍻", "🍾", "🧃", "🫖", "🍶", "🥃", "🥤", "🍹"].shuffled(),
                                     nPairs: nPairs, Color: .pink),
        Theme(name: "Food", emojis:
                        ["🍔", "🌽", "🌯", "🌭", "🌮", "🍕", "🍗", "🍟", "🥐", "🍛", "🍱", "🍲"].shuffled(),
                     nPairs: nPairs, Color: .yellow),
        Theme(name: "Wearing", emojis:
                        ["🥼", "👠", "👙", "👗", "👢", "🧥", "👖", "🥾", "🧣", "👔", "👚", "🩳"].shuffled(),
                     nPairs: nPairs, Color: .green),
        Theme(name: "Sports", emojis:
                        ["🚲", "🏀", "🏸", "⛹️‍♀️", "🎾", "🏓", "🏑", "⚾️", "🏈", "🏊‍♀️", "🏄🏿‍♀️", "🚵"].shuffled(),
                     nPairs: nPairs, Color: .red)
    ]}
    
    
    struct Theme: Identifiable {
        
        
        let name: String
        var emojis: [String]
        let nPairs: Int
        let Color: Color
        let id = UUID()
    
        
    }
}
