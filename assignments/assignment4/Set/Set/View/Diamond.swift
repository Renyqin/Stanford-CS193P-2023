//
//  Diamond.swift
//  Set
//
//  Created by Chenqin zhang on 2024/2/21.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    Diamond()
        .stroke(.red, lineWidth: 3)
        .foregroundColor(.red.opacity(0.5))
        .minimumScaleFactor(0.1)
        .aspectRatio(2, contentMode: .fit)
    
}
