//
//  MeetModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 27/08/26.
//
import Foundation
import FoundationModels

@Generable
struct Meet {
    @Guide(description: "An exciting name for the first date idea.")
    let title: String

    @Guide(description: "A brief and engaging description of the first date.")
    let description: String

    @Guide(description: "A list of 3 tips on what to do")
    @Guide(.count(3))
    let ideas: [String]


}
@Generable
struct Suggestion {
    @Guide(description: "A list of 3 date ideas.")
    @Guide(.count(3))
    let suggestions: [Meet]
}

