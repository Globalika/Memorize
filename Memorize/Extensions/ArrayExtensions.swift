//
//  ArrayExtensions.swift
//  Memorize
//
//  Created by Volodymyr Seredovych on 05.11.2021.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
