//
//  ThemeChooserView.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/3/31.
//

import SwiftUI

struct ThemeChooserView: View {
    @ObservedObject var themeChooser: ThemeChooser
    typealias Theme = ThemeStore.Theme
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(themeChooser.themes) { theme in 
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame())){
                        themeView(theme)
                    }
                    
                }
                
                
            }
            .navigationTitle("Themes")
            .toolbar {
                Button {
                    
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
            Text("\(theme.nPairs) pairs from \(theme.emojis.joined())").lineLimit(1)
        }
    }
}

#Preview {
    ThemeChooserView(themeChooser: ThemeChooser())
}
