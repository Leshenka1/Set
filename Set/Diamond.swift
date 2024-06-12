//
//  Diamond.swift
//  Set
//
//  Created by Алексей Зубель on 4.06.24.
//

import SwiftUI


struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.minY)
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return p
    }
}
