//
//  ThemeChooserView.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/3/31.
//

import SwiftUI

struct ThemeChooserView: View {
    typealias Theme = ThemeStore.Theme
    @ObservedObject var themeChooser: ThemeChooser
    @State private var showCursorTheme = false
    @State private var emptyTheme = Theme(name: "", emojis: "🍶🍲", nPairs: 2, Color: .black)
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(themeChooser.themes) { theme in 
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeID: theme.id, themeChooser: themeChooser), themeID: theme.id)){
                        
                        themeView(theme)
                    }
                }
            }
            .navigationDestination(isPresented: $showCursorTheme){
                ThemeEditor(theme: $emptyTheme)
            }
            .navigationTitle("Themes")
            .toolbar {
                Button {
                    showCursorTheme = true
                    themeChooser.append(theme: emptyTheme)
                } label: {
                    Image(systemName: "plus")
                }
        }
        }
            
    }
    
    func themeView(_ theme: Theme) -> some View {
        VStack(alignment: .leading){
            Text(theme.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(theme.Color)
            Text("\(theme.nPairs) pairs from \(theme.emojis)").lineLimit(1)
        }
    }
}

#Preview {
    ThemeChooserView(themeChooser: ThemeChooser())
}
