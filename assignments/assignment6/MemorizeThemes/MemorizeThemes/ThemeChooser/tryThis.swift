//
//  tryThis.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/4/2.
//

import SwiftUI

struct tryThis: View {
    @State private var tasks = ["Task 1", "Task 2", "Task 3"]
        @State private var isEditMode = false
        
    var body: some View {
        Text("Swipe me!")
            .swipeActions {
                Button(action: {
                    // Perform an action when the button is tapped
                }) {
                    Text("Delete")
                }
            }
    }
}


#Preview {
    tryThis()
}
