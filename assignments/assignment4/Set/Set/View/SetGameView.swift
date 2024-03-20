//
//  ContentView.swift
//  Set
//
//  Created by Chenqin zhang on 2024/1/2.
//

import SwiftUI

struct SetGameView: View {
    typealias Card = SetGame.Card
    @ObservedObject var setGameTable: SetGameTable
    private let aspectRatio: CGFloat = 1.25
    private let deckWidth: CGFloat = 50
    
//    private let dealAnimation: Animation = .easeInOut(duration: 1)
//    private let dealInterval: TimeInterval = 0.15
    var body: some View {
        ZStack {
            
            VStack {
                cards
                    .padding(5)
                
                HStack {
                    Spacer()
                    deck
                    discardPile
                    Spacer()
                    Button("New Game") {
                        setGameTable.newGame()
                    }
                    Spacer()
                    Button("Shuffle") {
                        withAnimation {
                            setGameTable.shuffleDisplayCards()
                        }
                        
                    }
                    Spacer()
                }
                .font(.title3)
            }
            .padding()
        }
    }
    
    @Namespace private var dealingNamespace
    @Namespace private var discardNamespace
    
    private func view(for card: SetGame.Card) -> some View {
        CardView(card: card, setGameTable: setGameTable)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
    }
    
    private var deck: some View {
        ZStack {
            ForEach(setGameTable.undealtCards) { card in
                
                view(for: card)
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            setGameTable.deal()
            setGameTable.dealThreeMoreCards()
            setGameTable.moveToDiscardPile()
            if setGameTable.getSetStatus() == SetGame.SetStatus.notMatch {
                setGameTable.trembleCard()
            }
        }
    }
    
    private var discardPile: some View {
        ZStack {
            if setGameTable.discardCards.isEmpty{
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                    .frame(width: deckWidth, height: deckWidth / aspectRatio)
                    
            }else{
                ForEach(setGameTable.discardCards) { card in
                    view(for: card)
                }
                .frame(width: deckWidth, height: deckWidth / aspectRatio)
            }
            
        }
    }
    
    private var cards: some View {
    
        AspectVGrid(setGameTable.getDisplayCardsArray(), aspectRatio: aspectRatio) { card in
            view(for: card)
                .padding(5)
                .onTapGesture {
                    setGameTable.choose(card)
                    setGameTable.moveToDiscardPile()
            }
        }
    }

}
    


#Preview {
    SetGameView(setGameTable: SetGameTable())
}
