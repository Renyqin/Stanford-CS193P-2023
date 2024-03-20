//
//  AspectVGrid.swift
//  Memorize
//
//  Created by CS193p Instructor on 4/24/23.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    var aspectRatio: CGFloat
    let content: (Item) -> ItemView
    
    init( _ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        //print(items.count)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
                        
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
//        print("size: \(size)")
//        print("size width: \(size.width)")
//        print("count: \(count)")
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
//                print("upper: \((size.width / columnCount).rounded(.down))")
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
//            print(columnCount)
        } while columnCount < count
//        print("column count \(columnCount)")
        
//        print("gridItemWidth \(max(size.width / count, size.height * aspectRatio).rounded(.down))")
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
