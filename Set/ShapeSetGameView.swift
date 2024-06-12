//
//  ContentView.swift
//  Set
//
//  Created by Алексей Зубель on 29.05.24.
//

import SwiftUI

let cardAspectRatio: CGFloat = 3/4


struct ShapeSetGameView: View {
    @ObservedObject var shapeSetGameViewModel: ShapeSetGame
    
    var body: some View {
        VStack {
            cards
            Spacer()
            buttons
        }
        .padding()
    }
    //TODO: put grid drawing to another file (lecture 6)
    var cards: some View {
        GeometryReader { geometry in
            let adaptiveCardWidth = calculateAdaptiveWidth (
                cardsCount: shapeSetGameViewModel.cardsInGame.count,
                size: geometry.size,
                cardAspectRatio: cardAspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: adaptiveCardWidth, maximum: 150), spacing: 0)], spacing: 0){
                ForEach(shapeSetGameViewModel.cardsInGame){card in
                    CardView(card: card, isChosen: shapeSetGameViewModel.isChoosen(card: card))
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .padding(2)
                        .onTapGesture {
                            shapeSetGameViewModel.chooseCard(card: card)
                        }
                }
            }
        }
    }
    
    func calculateAdaptiveWidth(cardsCount: Int, size: CGSize, cardAspectRatio: CGFloat) -> CGFloat {
        var rowCount: CGFloat = 1.0
        var cardHeight, cardWidth, cardRowCount: CGFloat
        repeat {
            cardRowCount = (CGFloat(cardsCount) / rowCount).rounded(.up)
            cardWidth = CGFloat(size.width) / cardRowCount
            cardHeight = CGFloat(cardWidth) / cardAspectRatio
            rowCount += 1
        } while (cardHeight*(rowCount) < size.height - 150)
        return cardWidth
    }
    
    var buttons: some View {
        HStack {
            Button(
                action: {
                    withAnimation() {
                        shapeSetGameViewModel.newGame()
                    }
            }, label: {
                Text("New Game")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .background(Color.gray.brightness(0.3))
                    .cornerRadius(10)
            })
            Spacer().frame(width: 100)
            Button(action: {
                withAnimation() {
                    shapeSetGameViewModel.addCardsInGame()
                }
            }, label: {
                Text("Add Cards")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .background(shapeSetGameViewModel.isDeckEmpty ? Color.red.brightness(0.6) : Color.gray.brightness(0.3))
                    .cornerRadius(10)
            })
                .disabled(shapeSetGameViewModel.isDeckEmpty)
        }
    }
    
}

#Preview {
    ShapeSetGameView(shapeSetGameViewModel: ShapeSetGame(deck: []))
}
