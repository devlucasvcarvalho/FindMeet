//
//  StylesModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 04/09/26.
//
import Foundation

enum MeetStyleEnum: String, CaseIterable, Identifiable {
    case gastronomic
    case sportive
    case cultural
    case homemade
    case festive
    case funy
    case creative
    case adventurous
    
    
    var styles: String {
        switch self {
        case .gastronomic:
            return "Gastronomico"
        case .sportive:
            return "Esportivo"
        case .cultural:
            return "Cultural"
        case .homemade:
            return "Econômico"
        case .festive:
            return "festa"
        case .funy:
            return "divertido"
        case .creative:
            return "criativo"
        case .adventurous:
            return "aventura"
        }
    }
    var imageName: String {
         switch self {
         case .gastronomic:
             return "cozinheiro"
         case .sportive:
             return "exercicio"
         case .cultural:
             return "cultural"
         case .homemade:
             return "economico 1"
         case .festive:
             return "festeiro 1"
         case .funy:
             return "Divertido"
         case .creative:
             return "Criativo 2"
         case .adventurous:
             return "Aventureira"
         }
     }
    
    var id: String { self.rawValue.capitalized }
}

extension MeetStyleEnum: CarouselItem {
    var title: String {
        styles
    }
}

