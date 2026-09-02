//
//  PickerOptions.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 02/09/26.
//

import Foundation

enum MeetStyleEnum: String, CaseIterable, Identifiable {
    case gastronomic
    case sportive
    case cultural
    case homemade
    case festive
    
    var styles: String {
        switch self {
        case .gastronomic:
            return "Gastronomico"
        case .sportive:
            return "Esportivo"
        case .cultural:
            return "Cultural"
        case .homemade:
            return "Idoso"
        case .festive:
            return "Rolezão"
        }
    }
    
    var id: String { self.rawValue.capitalized }
}

enum MeetTimeEnum: String, CaseIterable, Identifiable {
    case night
    case evening
    case morning
    
    var species: String {
        switch self {
        case .night:
            return "Noite"
        case .morning:
            return "Manhã"
        case .evening:
            return "Tarde"
            
        }
    }
    var id: String { self.rawValue.capitalized }
}

