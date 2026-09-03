//
//  MeetModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 27/08/26.
//

import FoundationModels
import Foundation



@Generable
struct Meet {
    @Guide(description: "The title of the meet")
    let title: String
    
    @Guide(description: "The description of the meet")
    let description: String
    
    @Guide(description: "The tip for the meet")
    let tip: String

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
