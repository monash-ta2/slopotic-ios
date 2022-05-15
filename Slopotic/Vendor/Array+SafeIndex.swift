//
//  Array+SafeIndex.swift
//  Slopotic
//
//  Created by Weiyi Kong on 15/5/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
