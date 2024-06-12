//
//  SetApp.swift
//  Set
//
//  Created by Алексей Зубель on 29.05.24.
//

import SwiftUI

@main
struct SetApp: App {
    @StateObject var game = ShapeSetGame(deck: [])
    
    var body: some Scene {
        WindowGroup {
            ShapeSetGameView(shapeSetGameViewModel: game)
        }
    }
}
