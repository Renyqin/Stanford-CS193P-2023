//
//  ThemeChooser.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/3/31.
//

import Foundation

class ThemeChooser: ObservableObject {
    private(set) var themeStore = ThemeStore()
    var themes : [ThemeStore.Theme]
    
    init() {
        self.themes = ThemeStore.builtins
    }
    
    

}
