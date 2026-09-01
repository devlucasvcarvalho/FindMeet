//
//  ModelTest.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 31/08/26.
//

import FoundationModels
import Playgrounds

@Generable
struct Recipe {
    @Guide(description: "The recipe title")
    let title: String

    @Guide(description: "List of ingredients")
    let ingredients: [String]

    @Guide(description: "Step-by-step instructions")
    let instructions: String
}

@Generable
struct Place {
    @Guide(description: "The place name")
    let name: String

    @Guide(description: "The place address")
    let address: String
}

@Generable
struct SearchPlacesOutput {
    @Guide(description: "Places found")
    let places: [Place]
}
