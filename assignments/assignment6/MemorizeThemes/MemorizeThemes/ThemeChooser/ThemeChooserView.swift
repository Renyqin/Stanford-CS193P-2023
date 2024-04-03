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
    @State private var selectedTheme: Theme?
//    @State private var emptyTheme = Theme(name: "", emojis: "🍶🍲", nPairs: 2, color: RGBA(color: .black))
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(themeChooser.themes) { theme in 
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeID: theme.id, themeChooser: themeChooser), themeID: theme.id)){
                        
                        themeView(theme)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            selectedTheme = theme
                            
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                        .tint(.blue)
                    }
                }
                .onDelete{ indexSet in
                    withAnimation {
                        themeChooser.themes.remove(atOffsets: indexSet)
                        themeChooser.printThemes()
                        
                    }
                }
                .deleteDisabled(themeChooser.themes.count <= 1)
            }
            .sheet(item: $selectedTheme, content: { item in
                if let index = themeChooser.themes.firstIndex(where: { $0.id == item.id }){
                    ThemeEditor(theme: $themeChooser.themes[index])
                }
            })

            .navigationDestination(isPresented: $showCursorTheme){
                ThemeEditor(theme: $themeChooser.themes.last!)
            }
            .navigationTitle("Themes")
            .toolbar {
                Button {
                    themeChooser.append()
                    showCursorTheme = true
                   
                } label: {
                    Image(systemName: "plus")
                }
        }
        }
            
    }
    
    func themeView(_ theme: Theme) -> some View {
        let allPair = theme.emojis.count == theme.nPairs
        return VStack(alignment: .leading){
            Text(theme.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(rgba: theme.color))
            Text(allPair ? "All of \(theme.emojis)" : "\(theme.nPairs) pairs from \(theme.emojis)")
        }
    }
}

#Preview {
    ThemeChooserView(themeChooser: ThemeChooser())
}
