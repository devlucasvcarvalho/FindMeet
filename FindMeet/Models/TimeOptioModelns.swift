//
//  PickerOptions.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 02/09/26.
//

import Foundation

enum MeetTimeEnum: String, CaseIterable, Identifiable {
    case morning
    case evening
    case night
    
    var time: String {
        switch self {
        case .morning:
            return "manhã"
        case .evening:
            return "tarde"
        case .night:
            return "noite"
            
        }
    }
    var imageName: String {
         switch self {
         case .morning:
             return "manhã"
         case .evening:
             return "tarde"
         case .night:
             return "noite"

         }
     }
    var id: String { self.rawValue.capitalized }
}

extension MeetTimeEnum: CarouselItem {

    var title: String {
        time
    }
}
