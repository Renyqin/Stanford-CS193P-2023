//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by CS193p Instructor on 5/8/23.
//  Copyright (c) 2023 Stanford University
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
    @StateObject var defaultDocument = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Main")

    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
                .environmentObject(paletteStore)
        }
    }
}
