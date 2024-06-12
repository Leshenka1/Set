//
//  CardView.swift
//  Set
//
//  Created by Алексей Зубель on 4.06.24.
//

import SwiftUI

struct CardView: View{
    var card: Card
    var isChosen: Bool
    
    init(card: Card, isChosen: Bool) {
        self.card = card
        self.isChosen = isChosen
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let base = RoundedRectangle(cornerRadius: 10.0)
                base.strokeBorder(isChosen ? (card.inMatch ? .red : .purple) : .black, lineWidth: isChosen ? 5 : 2)
                    .background(base.fill(.white))
                    .overlay(content
                                .foregroundColor(shapeColor)
                                .frame(width: geometry.size.width - 10, height: geometry.size.width)
                    )
            }
        }
    }
    
    @ViewBuilder
    var shape: some View {
        switch card.shapeType {
        case .rectangle:
            Rectangle()
        case .diamond:
            Diamond()
        case .oval:
            Ellipse()
        }
    }
    
    var shapeColor: Color {
        switch card.shapeColor {
        case ShapeColor.red:
            return Color.red
        case ShapeColor.blue:
            return Color.blue
        case ShapeColor.green:
            return Color.green
        }
    }
    
    var shapeTexture: Double {
        switch card.shapeTexture {
        case ShapeTexture.fill:
            return 1.0
        case ShapeTexture.semiTransparent:
            return 0.4
        case ShapeTexture.circuit:
            return 0
        }
    }
    
    @ViewBuilder
    func shapeWithStroke() -> some View {
        switch card.shapeType {
        case .rectangle:
            Rectangle().stroke(lineWidth: shapeTexture == 0 ? 2 : 0)
        case .diamond:
            Diamond().stroke(lineWidth: shapeTexture == 0 ? 2 : 0)
        case .oval:
            Ellipse().stroke(lineWidth: shapeTexture == 0 ? 2 : 0)
        }
    }
    
    var content: some View {
        VStack{
            ForEach(0..<card.shapeNum, id: \.self) { _ in
                shape
                    .aspectRatio(4, contentMode: .fit)
                    .foregroundColor(shapeColor)
                    .opacity(shapeTexture)
                    .overlay(
                        shapeWithStroke()
                            .foregroundColor(shapeColor)
                    )
            }
        }
    }
    
}

#Preview {
    CardView(card: Card(shapeType: .diamond, shapeColor: .blue, shapeTexture: .fill, shapeNum: 1, id: 1), isChosen: false)
        .padding()
}
