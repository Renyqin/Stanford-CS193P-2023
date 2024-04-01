//
//  Extensions.swift
//  MemorizeThemes
//
//  Created by Chenqin zhang on 2024/4/1.
//

import Foundation



//  Created by CS193p Instructor on 5/8/23.
//  Copyright (c) 2023 Stanford University
extension String {
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1️⃣)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}


extension Array where Element: Hashable {
    func uniqueElements() -> [Element] {
        var uniqueArray = [Element]()
        var uniqueSet = Set<Element>()
        
        for element in self {
            if !uniqueSet.contains(element) {
                uniqueArray.append(element)
                uniqueSet.insert(element)
            }
        }
        
        return uniqueArray
    }
}
