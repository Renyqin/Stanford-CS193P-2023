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
