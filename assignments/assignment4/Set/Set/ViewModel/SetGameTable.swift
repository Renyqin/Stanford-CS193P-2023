//
//  SetGame.swift
//  Set
//
//  Created by Chenqin zhang on 2024/2/17.
//

import Foundation
import SwiftUI

class SetGameTable: ObservableObject {
    @Published private var game: SetGame
    private let initialNumber = 20
    @Published private(set) var presentNumber: Int
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    @Published private var shouldTremble = false

    
    init() {
        presentNumber = initialNumber
        game = SetGameTable.createSetGame()
        game.shuffle()
        
    }
    
//    func isDealt(_ card: SetGame.Card) -> Bool {
//        return displayCards.contains(card.id) || discardCardsId.contains(card.id)
//    }
//    
//    var undealtCards: [SetGame.Card] {
//        cards.filter { !isDealt($0) }
//    }
    
    
    func shuffleDisplayCards() {
        game.shuffleDisplayCards()
    }
    
    func trembleCard() {
        withAnimation {
            self.shouldTremble = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                self.shouldTremble = false
            }
        }
    }
    
    func deal() {
        var delay: TimeInterval = 0
        var count = 0
        for i in game.cards.indices {
            if count <= presentNumber && undealtCards.contains(game.cards[i])  {
                faceUpCard(with: game.cards[i].id)
                withAnimation(dealAnimation.delay(delay)) {
                    insertDisplayCard(game.cards[i].id)
                    appendDisplayCard(game.cards[i])
    //                print("cards \(setGameTable.cards)")
                    
                }
                delay += dealInterval
            }
            count += 1
        }
    }
    
    
    func dealThreeMoreCards(){
        if getSetStatus() == SetGame.SetStatus.matched {
            game.removeMatchingSet()
        } else {
            if presentNumber <= game.cards.count - 3 {
                presentNumber += 3
                print(presentNumber)
            }
        }
    }
    
    func moveToDiscardPile() {
        var delay: TimeInterval = 0
        for card in game.matchCards{
            withAnimation(dealAnimation.delay(delay)) {
                game.removeDisplayCard(card)
                game.removeDisplayCardId(card)
                game.insertDiscardCardId(card: card)
                game.appendDiscardCard(card: card)
            }
            delay += dealInterval
        }
        game.matchCards = []
    }
    
    
//    func removeMatchSet(){
//        game.removeMatchingSet()
//    }
    
    
    func getDisplayCardsArray() -> [SetGame.Card]{
        return game.displayCards
    }
    
    func getDisplayCards() -> Set<SetGame.Card.ID>{
        return game.displayCardsId
    }
    
    func insertDisplayCard(_ id: SetGame.Card.ID) {
        game.insertDisplayCard(id)
    }
    
    func appendDisplayCard(_ card: SetGame.Card) {
        game.appendDisplayCard(card)
    }
    
    
    func isDealt(_ card: SetGame.Card) -> Bool {
        game.isDealt(card)
    }

    var undealtCards: [SetGame.Card] {
        cards.filter { !isDealt($0) }
    }
    
//    var discardCards: [SetGame.Card] {
//        cards.filter { game.discardCardsId.contains($0.id) }
//    }
    
    var discardCards: [SetGame.Card] {
        game.discardCards
    }
    
    
    
    private static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    func getSetStatus() -> SetGame.SetStatus{
        return game.setStatus
    }
    
    func choose(_ card: SetGame.Card) {
        game.choose(card)
    }
    
    func newGame(){
        presentNumber = initialNumber
        game = SetGameTable.createSetGame()
        game.shuffle()
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    
    var cards: Array<SetGame.Card> {

        game.cards
        
    }
    
    func faceUpCard(with id: SetGame.Card.ID) {
        game.faceUpCard(with: id)
    }
    
    func getTotalCardsCount() -> Int {
        return game.cards.count
    }
    
}
