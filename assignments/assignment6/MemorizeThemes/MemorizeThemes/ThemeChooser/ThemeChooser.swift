//
//  ThemeChooser.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/3/31.
//

import Foundation

class ThemeChooser: ObservableObject {
    typealias Theme = ThemeStore.Theme
    private(set) var themeStore = ThemeStore()
    var themes : [Theme]
    
    init() {
        self.themes = ThemeStore.builtins
    }
    
    func append(theme: Theme){
        themes.append(theme)
    }
    
    

    func choseTheme(by themeId: UUID) -> Theme {
        if let index = themes.firstIndex(where: { $0.id == themeId}) {
            return themes[index]
        }
        print("-----------------------------")
        print(themeId)
        print(themes)
        return themes[0]
        
    }
    
    

}
