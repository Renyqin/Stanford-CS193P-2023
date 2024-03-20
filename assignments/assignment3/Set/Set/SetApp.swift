//
//  SetApp.swift
//  Set
//
//  Created by Chenqin zhang on 2024/1/2.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setGameTable: SetGameTable())
        }
    }
}
