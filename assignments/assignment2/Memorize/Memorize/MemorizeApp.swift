//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Chenqin zhang on 2024/3/16.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
