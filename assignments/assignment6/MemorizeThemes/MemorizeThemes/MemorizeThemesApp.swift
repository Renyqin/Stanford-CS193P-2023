//
//  MemorizeThemesApp.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/3/30.
//

import SwiftUI

@main
struct MemorizeThemesApp: App {
//    @StateObject var game = EmojiMemoryGame()
    @StateObject var themeChooser = ThemeChooser()
    var body: some Scene {
        WindowGroup {
            ThemeChooserView(themeChooser: themeChooser)
        }
    }
}
