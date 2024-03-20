//
//  ContentView.swift
//  Set
//
//  Created by Chenqin zhang on 2024/1/2.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGameTable: SetGameTable
    private let aspectRatio: CGFloat = 1.21
    var body: some View {
        ZStack {
            
            VStack {
                
                cards
                    .padding(5)
                
                HStack {
                    Spacer()
                    Button("New Game") {
                        setGameTable.newGame()
                    }
                    if setGameTable.getTotalCardsCount() - setGameTable.presentNumber - 1 > 0 {
                        Spacer()
                        Button("Deal 3 More Cards"){
                            setGameTable.dealThreeMoreCards()
                        }
                        
                    }
                    Spacer()
                    
                }
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                
                
                
            }
            .padding()
        }
        
        
        
        
    }
    
    private var cards: some View {
    
        AspectVGrid(setGameTable.cards, aspectRatio: aspectRatio) { card in
            CardView(card : card, setGameTable: setGameTable)
                .padding(5)
                .onTapGesture {
                    setGameTable.choose(card)
                }

        }
    }
}
    


#Preview {
    SetGameView(setGameTable: SetGameTable())
}
