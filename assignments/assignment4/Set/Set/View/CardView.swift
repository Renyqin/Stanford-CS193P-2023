//
//  CardView.swift
//  Set
//
//  Created by Chenqin zhang on 2024/1/3.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    @ObservedObject var setGameTable: SetGameTable
    @State private var isTrembling = false
//    @State private var isNotMatch = false
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                
 

                
                if card.isSelected {
                    if setGameTable.getSetStatus() == SetGame.SetStatus.matched {
                        base.strokeBorder(Color.green, lineWidth: 7)
                    } else if setGameTable.getSetStatus() == SetGame.SetStatus.notMatch {
                        base.strokeBorder(Color.red, lineWidth: 7)
                           
                    } else {
                        base.strokeBorder(Color.orange, lineWidth: 7)
                    }
                    
                } else {
                    base.strokeBorder(lineWidth: 2)
                }
                
                
                switch card.content.shape {
                case .diamond:
                    stackShape(applyShading(to: Diamond()))
                case .squiggle:
                    stackShape(applyShading(to: Rectangle()))
                case .oval:
                    stackShape(applyShading(to: RoundedRectangle(cornerRadius: 20)))
                }
                
                base.fill().opacity(card.isFaceUp ? 0 : 1)
            }
            
        }
    }
    
    
    func trythis() -> some View {
        applyShading(to: Rectangle())
    }
    
    func stackShape(_ shape: some View) -> some View {
        VStack {
            switch card.content.num {
                case .one:
                    shape
                case.two:
                    shape
                    shape
                default:
                    shape
                    shape
                    shape
                }
        }
        .padding(10)
    }
    
    @ViewBuilder
    func applyShading(to shape: some Shape) -> some View {
        
        switch card.content.shade {
        case .solid:
            shape
                .fill(card.content.color)
                .minimumScaleFactor(0.1)
                .aspectRatio(2, contentMode: .fit)
        case .striped:
            shape
                .foregroundColor(card.content.color.opacity(0.5))
                .overlay(shape
                    .stroke(card.content.color, lineWidth: 5))
                .minimumScaleFactor(0.1)
                .aspectRatio(2, contentMode: .fit)
        case .open:
            shape
                .stroke(card.content.color, lineWidth: 3)
                .foregroundColor(.white)
                .minimumScaleFactor(0.1)
                .aspectRatio(2, contentMode: .fit)
        }
    }
}



#Preview {
    
    HStack {
        CardView(card: SetGame.Card(content:
                                    Content(
                                            shape: Content.Shape.oval,
                                            color: .green,
                                            num: Content.NumberOfShape.two,
                                            shade: Content.Shading.open),
                                    id:String(0)),setGameTable: SetGameTable())
        CardView(card: SetGame.Card(content:
                                    Content(
                                            shape: Content.Shape.oval,
                                            color: .green,
                                            num: Content.NumberOfShape.two,
                                            shade: Content.Shading.open),
                                    id:String(0)),setGameTable: SetGameTable())
    }
}
