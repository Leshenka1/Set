//
//  SetGame.swift
//  Set
//
//  Created by Алексей Зубель on 29.05.24.
//

import Foundation

struct SetGame{
    let numberOfShapes: Array<Int> = [1, 2, 3]
    var chosenCards: Array<Card> = []
    var deck: Array<Card> = []
    var cardsInGame: Array<Card> = []
    var indicesToRemove: Array<Int> = []
    
    init() {
        var id = 0
        for shape in ShapeType.allCases {
            for color in ShapeColor.allCases {
                for texture in ShapeTexture.allCases {
                    for shapeNumber in numberOfShapes{
                        self.deck.append(Card( shapeType: shape, shapeColor: color, shapeTexture: texture, shapeNum: shapeNumber, id: id))
                        id += 1
                    }
                }
            }
        }
        self.deck.shuffle()
        self.cardsInGame = removeCardsFromDeck(cardsNumber: 12)
    }
    
    mutating func addCardsInGame() {
        cardsInGame += removeCardsFromDeck(cardsNumber: 3)
    }
    
    mutating func removeCardsFromDeck(cardsNumber: Int) -> Array<Card> {
        var cards: Array<Card> = []
        if (deck.count > 0) {
            for _ in 0..<cardsNumber{
                cards.append(deck.removeLast())
            }
            return cards
        }
        return cards
    }
    
    mutating func chooseCard(card: Card) {
        if (isNewCardChoosen(card: card)) {
            chosenCards.append(card)
        }
        
        if ( chosenCards.count != 3) {
            return
        }
        
        if(!isSet(setCards: chosenCards)){
            matchCards(true)
            return
        }

        for chosenCard in chosenCards {
            let index = cardsInGame.firstIndex { card in
                chosenCard.id == card.id
            }
            indicesToRemove.append(index!)
        }
        
        removeGameCards(indexes: indicesToRemove)
    }
    
    mutating func removeGameCards(indexes: Array<Int>) {
        let sortedIndexes = indexes.sorted(by: >)
        for index in sortedIndexes {
            print(index)
            cardsInGame.remove(at: index)
        }
        indicesToRemove = []
    }
    
    mutating func matchCards(_ flag: Bool) {
        for index in cardsInGame.indices{
            for chosenCard in chosenCards{
                if(cardsInGame[index].id == chosenCard.id) {
                    cardsInGame[index].inMatch = flag
                }
            }
        }
    }
    
    mutating func isNewCardChoosen(card: Card) -> Bool{
        if (chosenCards.count < 3) {
            for index in chosenCards.indices {
                if(chosenCards[index].id == card.id) {
                    chosenCards.remove(at: index)
                    return false
                }
            }
        } else {
            matchCards(false)
            chosenCards = []
        }
        return true
    }
    
    //Set game algorithm
    func isSet(setCards: Array<Card>) -> Bool {
                    //first condition
        if((setCards[0].shapeNum == setCards[1].shapeNum && setCards[1].shapeNum == setCards[2].shapeNum ||
           setCards[0].shapeNum != setCards[1].shapeNum && setCards[1].shapeNum != setCards[2].shapeNum && setCards[2].shapeNum != setCards[0].shapeNum)
            &&      //second condition
        (setCards[0].shapeType == setCards[1].shapeType && setCards[1].shapeType == setCards[2].shapeType ||
           setCards[0].shapeType != setCards[1].shapeType && setCards[1].shapeType != setCards[2].shapeType && setCards[2].shapeType != setCards[0].shapeType)
            &&      //third condition
        (setCards[0].shapeColor == setCards[1].shapeColor && setCards[1].shapeColor == setCards[2].shapeColor ||
           setCards[0].shapeColor != setCards[1].shapeColor && setCards[1].shapeColor != setCards[2].shapeColor && setCards[2].shapeColor != setCards[0].shapeColor)
            &&      //forth condition
        (setCards[0].shapeTexture == setCards[1].shapeTexture && setCards[1].shapeTexture == setCards[2].shapeTexture ||
           setCards[0].shapeTexture != setCards[1].shapeTexture && setCards[1].shapeTexture != setCards[2].shapeTexture && setCards[2].shapeTexture != setCards[0].shapeTexture)) {
            return true
        }
        return false
    }
    
    func isChoosen(card: Card) -> Bool {
        for index in chosenCards.indices{
            if(chosenCards[index].id == card.id) {
                return true
            }
        }
        return false
    }
}

enum ShapeType: CaseIterable{
    case diamond
    case rectangle
    case oval
}

enum ShapeColor: CaseIterable{
    case red
    case green
    case blue
}

enum ShapeTexture: CaseIterable{
    case fill
    case semiTransparent
    case circuit
}

struct Card: Identifiable {
    let shapeType: ShapeType
    let shapeColor: ShapeColor
    let shapeTexture: ShapeTexture
    let shapeNum: Int
    var id: Int
    var inMatch: Bool = false
}
