//
//  MeetModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 27/08/26.
//

import FoundationModels
import Foundation



@Generable
struct MeetModel {
    @Guide(description: "The title of the meet")
    let title: String
    
    @Guide(description: "The description of the meet")
    let description: String
    
    @Guide(description: "The tip for the meet")
    let tip: String

}
