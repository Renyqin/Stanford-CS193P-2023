//
//  PaletteChooser.swift
//  Emoji Art
//
//  Created by CS193p Instructor on 5/10/23.
//  Copyright (c) 2023 Stanford University
//

import SwiftUI

struct PaletteChooser: View {
    @EnvironmentObject var store: PaletteStore
    
    var body: some View {
        HStack {
            chooser
            view(for: store.palettes[store.cursorIndex])
        }
        .clipped()
    }
    
    private var chooser: some View {
        AnimatedActionButton(systemImage: "paintpalette") {
            store.cursorIndex += 1
        }
        .contextMenu {
            AnimatedActionButton("New", systemImage: "plus") {
                store.insert(name: "Math", emojis: "+−×÷∝∞")
            }
            AnimatedActionButton("Delete", systemImage: "minus.circle", role: .destructive) {
                store.palettes.remove(at: store.cursorIndex)
            }
        }
    }
    
    private func view(for palette: Palette) -> some View {
        HStack {
            Text(palette.name)
            ScrollingEmojis(palette.emojis)
        }
        .id(palette.id)
        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
    }
}

struct ScrollingEmojis: View {
    let emojis: [String]
    
    init(_ emojis: String) {
        self.emojis = emojis.uniqued.map(String.init)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .draggable(emoji)
                }
            }
        }
    }
}

struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser()
            .environmentObject(PaletteStore(named: "Preview"))
    }
}
