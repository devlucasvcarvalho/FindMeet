//
//  SavedCardsModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 08/09/26.
//

import SwiftUI
import SwiftData

@Model
class SavedData {
    var title: String
    var time: String
    var descriptions: String
    var ideas: [String]
    init(
        title: String,
        time: String,
        descriptions: String,
        ideas: [String]
    ) {
        self.title = title
        self.time = time
        self.descriptions = descriptions
        self.ideas = ideas
    }
}
