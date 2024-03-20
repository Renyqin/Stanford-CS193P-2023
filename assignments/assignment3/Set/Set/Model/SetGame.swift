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
    private(set) var setStatus = 1
    
    
    init() {
        cards = []
        let contentColor:Array<Color> = [.red, .green, .purple]
        var id = 0
        for shape in Content.Shape.allCases {
            for color in contentColor {
                for num in Content.NumberOfShape.allCases {
                    for shade in Content.Shading.allCases {
                        let content = Content(shape:shape, color:color, num:num, shade: shade)
                        cards.append(Card(content: content, id:String(id)))
                        id += 1
                    }
                }
            }
        }
    }

    
    
    mutating func shuffle() {
        cards.shuffle()
        
        
    }
    
    mutating func choose(_ card: Card) {
        var selected = false
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            
            if selectedCards.count == 3 {
                for selectedCard in selectedCards {
                    if cards[chosenIndex].id == selectedCard.id {
                        return
                    }
                }
                setSetStatus()
                threeCardsSelected()
            }
            
            if selectedCards.count <= 2 {
                if cards[chosenIndex].isSelected {
                    selectedCards.removeAll { $0.id == cards[chosenIndex].id }
                } else {
                    selectedCards.append(cards[chosenIndex])
                    
                }
                
            }
            

            cards[chosenIndex].isSelected = !cards[chosenIndex].isSelected
            setSetStatus()
 
        }
    }
    
    private mutating func threeCardsSelected(){
            
        if checkCardMatching(cards: selectedCards) {
            removeMatchingSet()
        } else {
            for selected in selectedCards {
                for (index, element) in cards.enumerated() {
                    if element.id == selected.id {
                        cards[index].isSelected = false
                    }
                }
            }
        }
        selectedCards = []
        setSetStatus()
    }
    
    mutating func removeMatchingSet(){
        if checkCardMatching(cards: selectedCards) {
            for selected in selectedCards {
                for (index, element) in cards.enumerated() {
                    if element.id == selected.id {
                        cards.remove(at: index)
                    }
                }
            }
            selectedCards = []
            setSetStatus()
        }
    }
    
    private mutating func setSetStatus(){
        if selectedCards.count >= 3 {
            if checkCardMatching(cards: selectedCards) {
                setStatus = 2
                
            }else {
                setStatus = 3
            }
        } else {
            setStatus = 1
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
    
    
    struct Card: Equatable, Identifiable {
        
        var isSelected = false
        var content: Content
        
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
    
    enum ContentColor: CaseIterable {
        case red, green, purple
    }
    
    enum NumberOfShape: CaseIterable {
        case one, two, three
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
}
