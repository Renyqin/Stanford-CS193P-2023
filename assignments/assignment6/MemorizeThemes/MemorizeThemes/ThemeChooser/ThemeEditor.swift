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
                        .foregroundColor(theme.Color)
                    ColorPicker("", selection: $theme.Color)
                }
            }
            Section(header: Text("Emojis")){
                removeEmojis
                TextField("Add emojis here", text: $emojisToAdd)
                    .onChange(of: emojisToAdd, initial: true) { old, new  in
                        if new != old {
                            
                            theme.emojis.append(new)
                            theme.emojis = theme.emojis.uniqueElements().filter { $0.isEmoji }
                        }
                        
                        
                    }
                Stepper("\(theme.nPairs)", value: $theme.nPairs, in: 2...theme.emojis.count)
            }
        }
    }
    
    var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 25))]) {
                ForEach(theme.emojis.uniqueElements(), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            if let index = theme.emojis.firstIndex(of: emoji) {
                                theme.emojis.remove(at: index)
                            }
                        }
                    
                    
                }
            }
        }
    }
    
    
}


struct ThemeEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State private var theme = ThemeStore.Theme(name: "123", emojis: ["🚲", "🏀", "🏸", "⛹️‍♀️", "🎾", "🏓", "🏑", "⚾️", "🏈", "🏊‍♀️", "🏄🏿‍♀️", "🚵"], nPairs: 3, Color: .black)
        var body: some View {
            ThemeEditor(theme: $theme)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
