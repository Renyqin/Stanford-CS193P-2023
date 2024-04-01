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
                Text("\(theme.emojis.joined())")
                TextField("New emojis", text: $emojisToAdd)
                Stepper("\(theme.nPairs)", value: $theme.nPairs, in: 2...theme.emojis.count)
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
