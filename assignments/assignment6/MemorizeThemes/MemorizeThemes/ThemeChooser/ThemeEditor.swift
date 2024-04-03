//
//  ThemeEditor.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/4/1.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: ThemeStore.Theme
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Name")){
                HStack {
                    TextField("Name", text: $theme.name)
                        .foregroundColor(Color(rgba: theme.color))
                    ColorPicker("", selection: Binding(
                        get: {
                            Color(rgba: theme.color)
                        }, set: { newColor in
                            theme.color = RGBA(color: newColor)
                        }
                    
                    ))
                }
            }
            Section(header: Text("Emojis")){
                removeEmojis
                TextField("Add emojis here", text: $emojisToAdd)
                    .onChange(of: emojisToAdd, initial: true) { old, new  in
                        if new != old {
                            
                            theme.emojis  = (new + theme.emojis)
                                    .filter { $0.isEmoji }
                                    .uniqued
                        }
                        
                        
                    }
                Stepper("\(theme.nPairs)", value: $theme.nPairs, in: 2...theme.emojis.count)
            }
        }
    }
    
    var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis, you must keep at least two Emojis ").font(.caption).foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 25))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            if theme.emojis.count > 2 {
                                theme.emojis.remove(emoji.first!)
                                emojisToAdd.remove(emoji.first!)
                                if theme.nPairs > theme.emojis.count{
                                    theme.nPairs = theme.emojis.count
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    



struct ThemeEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State private var theme = ThemeStore.Theme(name: "123", emojis: "🚲🏀🏸⛹️‍♀️🎾🏓🏑⚾️🏈🏊‍♀️🏄🏿‍♀️🚵", nPairs: 3, color: RGBA(color: .black))
        var body: some View {
            ThemeEditor(theme: $theme)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
