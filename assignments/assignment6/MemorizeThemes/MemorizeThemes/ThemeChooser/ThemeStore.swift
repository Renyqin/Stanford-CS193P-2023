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
                                     nPairs: nPairs, Color: .pink)
    ]}
    
    
    
    
    
    // the themeId would be 0 to 5, so we have 6 distinct themes
    func choseTheme(themeId: Int, nPairs: Int) -> Theme {
        switch themeId {
        case 0:
            return Theme(name: "Halloween", emojis: 
                            ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"].shuffled(),
                         nPairs: nPairs, Color: .orange)
        case 1:
            return Theme(name: "Vehicle", emojis:
                            ["🚗", "🚖", "⛴️", "🚁", "🚚", "🚂", "🚀", "🚌", "🚑", "🚔", "🚜", "🚄"].shuffled(),
                         nPairs: nPairs, Color: .blue)
        case 2:
            return Theme(name: "Drink", emojis:
                            ["🥂", "🍵", "🥛", "🧋", "🍻", "🍾", "🧃", "🫖", "🍶", "🥃", "🥤", "🍹"].shuffled(),
                                 nPairs: nPairs, Color: .pink)
        case 3:
            return Theme(name: "Food", emojis:
                            ["🍔", "🌽", "🌯", "🌭", "🌮", "🍕", "🍗", "🍟", "🥐", "🍛", "🍱", "🍲"].shuffled(),
                         nPairs: nPairs, Color: .yellow)
        case 4:
            return Theme(name: "Wearing", emojis:
                            ["🥼", "👠", "👙", "👗", "👢", "🧥", "👖", "🥾", "🧣", "👔", "👚", "🩳"].shuffled(),
                         nPairs: nPairs, Color: .green)
        default:
            return Theme(name: "Sports", emojis:
                            ["🚲", "🏀", "🏸", "⛹️‍♀️", "🎾", "🏓", "🏑", "⚾️", "🏈", "🏊‍♀️", "🏄🏿‍♀️", "🚵"].shuffled(),
                         nPairs: nPairs, Color: .red)
        }
        
    }
    
    
    struct Theme: Identifiable {
        
        
        let name: String
        var emojis: [String]
        let nPairs: Int
        let Color: Color
        var id = UUID()
    
        
    }
}
