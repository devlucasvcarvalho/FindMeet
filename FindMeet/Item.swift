//
//  Item.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 26/08/26.
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
