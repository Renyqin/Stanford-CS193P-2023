//
//  Card.swift
//  Set
//
//  Created by Chenqin zhang on 2024/2/8.
//

import Foundation
import SwiftUI

struct SetGame {
    
    private(set) var cards: Array<Card>
    private(set) var selectedCards: Array<Card> = []
    private(set) var setStatus = SetStatus.lessThan3cards
    private(set) var displayCardsId = Set<SetGame.Card.ID>()
    private(set) var discardCardsId = Set<SetGame.Card.ID>()
    private(set) var displayCards = [SetGame.Card]()
    private(set) var discardCards = [SetGame.Card]()
    var matchCards: Array<Card> = []
    
    
    
    init() {
        self.cards = []
        let contentColor:Array<Color> = [.red, .green, .purple]
        var id = 0
        for shape in Content.Shape.allCases {
            for color in contentColor {
                for num in Content.NumberOfShape.allCases {
                    for shade in Content.Shading.allCases {
                        let content = Content(shape:shape, color:color, num:num, shade: shade)
                        self.cards.append(Card(content: content, id:String(id)))
                        id += 1
                    }
                }
            }
        }
    }
    
    mutating func shuffle() {
         cards.shuffle()

    }
    
    mutating func shuffleDisplayCards() {
        displayCards.shuffle()
    }
    
    func isDealt(_ card: SetGame.Card) -> Bool {
        return displayCardsId.contains(card.id) || discardCardsId.contains(card.id)
    }
    
    mutating func insertDisplayCard(_ id: Card.ID) {
        displayCardsId.insert(id)
    }
    
    mutating func appendDisplayCard(_ card: Card) {
        displayCards.append(card)
    }
    
    mutating func removeDisplayCard(_ card: Card){
        displayCards.removeAll { $0.id == card.id }
    }
    
    mutating func removeDisplayCardId(_ card: Card){
        discardCardsId.remove(card.id)
        
    }
    
    
    mutating func choose(_ card: Card) {


        setSetStatus()
        if let chosenIndex = displayCards.firstIndex(where: {$0.id == card.id}) {
            
            
            if selectedCards.count >= 3 {
                for selectedCard in selectedCards {
                    if displayCards[chosenIndex].id == selectedCard.id {
                        return
                    }
                }
                setSetStatus()
                threeCardsSelected()
            }
            
            if selectedCards.count <= 2 {
                if displayCards[chosenIndex].isSelected {
                    selectedCards.removeAll { $0.id == displayCards[chosenIndex].id }
                } else {
                    selectedCards.append(displayCards[chosenIndex])
                    
                }
                
            }
            

            displayCards[chosenIndex].isSelected = !displayCards[chosenIndex].isSelected
            setSetStatus()
 
        }
    }
    
    private mutating func threeCardsSelected(){
            
        if checkCardMatching(cards: selectedCards) {
            removeMatchingSet()
        } else {
            for selected in selectedCards {
                for (index, element) in displayCards.enumerated() {
                    if element.id == selected.id {
                        displayCards[index].isSelected = false
                    }
                }
            }
        }
        selectedCards = []
        //setSetStatus()
    }
    
    
    // Remove matched cards in display cards
    // threes thing
    // 1. remove correspond cards in displaycards
    // 2. remove correspond id in displaycardsId
    // 3. add card id to discardCardsID
    mutating func removeMatchingSet(){
        
//        displayCards = displayCards.filter { card in
//            !selectedCards.contains { $0.id == card.id }
//        }
//        displayCardsId = displayCardsId.filter { id in
//            !selectedCards.contains { $0.id == id }
//        }
        
        
        
//            for card in selectedCards{
//                discardCardsId.insert(card.id)
//                discardCards.append(card)
//            }
        
        
        matchCards = selectedCards
        
        selectedCards = []
        setSetStatus()
        
    }
    
    mutating func insertDiscardCardId(card: Card){
        discardCardsId.insert(card.id)
    }
    
    mutating func appendDiscardCard(card: Card){
        discardCards.append(card)
    }
    
    
    
    
    private mutating func setSetStatus(){
        if selectedCards.count >= 3 {
            if checkCardMatching(cards: selectedCards) {
                self.setStatus = SetStatus.matched
                
            }else {
                setStatus = SetStatus.notMatch
            }
        } else {
            setStatus = SetStatus.lessThan3cards
        }
    }
    
    private func checkCardMatching(cards: Array<Card>) -> Bool {
        
        return checkProperties(
                a: cards[0].content.color,
                b: cards[1].content.color,
                c: cards[2].content.color)
            && checkProperties(
                a: cards[0].content.num,
                b: cards[1].content.num,
                c: cards[2].content.num)
            && checkProperties(
                a: cards[0].content.shade,
                b: cards[1].content.shade,
                c: cards[2].content.shade)
            && checkProperties(
                a: cards[0].content.shape,
                b: cards[1].content.shape,
                c: cards[2].content.shape)
            
        
        
    }
    
    private func checkProperties<P:Equatable>(a : P, b: P, c: P) -> Bool{
        return ((a == b) && (b == c)) || ((a != b ) && (b != c) && (a != c))
    }

    enum SelectedCardError: Error {
        case NotThreeSelectedCard
    }
    
    enum SetStatus: Equatable {
        case matched, notMatch, lessThan3cards
    }
    
    mutating func faceUpCard(with id: Card.ID){
        for index in cards.indices {
            if cards[index].id == id {
                cards[index].isFaceUp = true
            }
        }
    }
    
    
    struct Card: Equatable, Identifiable {
        
        var isSelected = false
        var content: Content
        var isFaceUp = false
        
        var id: String
    }
}






struct Content: Equatable {
    private(set) var shape: Shape
    private(set) var color: Color
    private(set) var num: NumberOfShape
    private(set) var shade: Shading

    
    
    enum Shape: CaseIterable {
        case diamond, squiggle, oval
    }
    
//    enum ContentColor: CaseIterable {
//        case red, green, purple
//    }
    
    enum NumberOfShape: CaseIterable {
        case one, two, three
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
}
