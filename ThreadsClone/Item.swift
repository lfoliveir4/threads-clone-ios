//
//  Item.swift
//  ThreadsClone
//
//  Created by Luis Filipe Alves de Oliveira on 03/08/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
