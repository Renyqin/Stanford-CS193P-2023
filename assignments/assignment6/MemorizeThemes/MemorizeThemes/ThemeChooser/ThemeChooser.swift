//
//  ThemeChooser.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/3/31.
//

import Foundation


extension UserDefaults {
    func theme(forKey key: String) -> [ThemeStore.Theme] {
        if let jsonData = data(forKey: key),
           let decodedPalettes = try? JSONDecoder().decode([ThemeStore.Theme].self, from: jsonData) {
            return decodedPalettes
        } else {
            return []
        }
    }
    func set(_ themes: [ThemeStore.Theme], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}

class ThemeChooser: ObservableObject {
    typealias Theme = ThemeStore.Theme
    private(set) var themeStore = ThemeStore()
    
    
    private var userDefaultsKey = "ThemeStore: first"
    
    var themes : [Theme] {
        get {
            UserDefaults.standard.theme(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey:  userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init() {
        if themes.isEmpty {
            self.themes = ThemeStore.builtins
        }
        
    }
    
    func printThemes(){
        print("------------------")
        print(themes)
    }
    
    
    func append(name: String = "", emoji: String = "🍶🍲"){
        themes.append(Theme(name: name, emojis: emoji, nPairs: 2, color: RGBA(color: .mint)))
    }
    
    

    func choseTheme(by themeId: UUID) -> Theme {
        if let index = themes.firstIndex(where: { $0.id == themeId}) {
            return themes[index]
        }
        return themes[0]
        
    }
    
    

}
