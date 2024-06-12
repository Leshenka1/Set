//
//  ShapeSetGame.swift
//  Set
//
//  Created by Алексей Зубель on 29.05.24.
//

import SwiftUI

class ShapeSetGame: ObservableObject {
    
    @Published var shapeSetGameModel: SetGame

    var cardsInGame: Array<Card> {
        return shapeSetGameModel.cardsInGame
    }
    
    var isDeckEmpty: Bool {
        if(shapeSetGameModel.deck.count > 0){
            return false
        } else {
            return true
        }
    }
    
    init(deck: Array<Card>) {
        self.shapeSetGameModel = SetGame()
    }
    
    func createShapeGame() -> SetGame{
        return SetGame()
    }
    
    func addCardsInGame() {
        shapeSetGameModel.addCardsInGame()
    }
    
    func chooseCard(card: Card) {
        shapeSetGameModel.chooseCard(card: card)
    }
    
    
    func newGame() {
        shapeSetGameModel = createShapeGame()
    }
    
    func isChoosen(card: Card) -> Bool {
        shapeSetGameModel.isChoosen(card: card)
    }
    
    
    
}
