//
//  LoadingViewModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class MeetFlowState {
    //primeiro a selecionar:
    var user1SelectedStyle: MeetStyleEnum = .festive
    var user1SelectedTime: MeetTimeEnum = .night
    
    //segundo a selecionar:
    var user2SelectedStyle: MeetStyleEnum = .festive
    var user2SelectedTime: MeetTimeEnum = .night
    
    var suggestion: Suggestion?   // <- novo
    
    //var selectedStyleString: String { selectedStyle.styles }
    //var selectedTimeString: String { selectedTime.time }
    
    var promptQuery: String {
        """
        Pessoa 1 quer: Estilo do encontro: \(user1SelectedStyle). Período do encontro: \(user1SelectedTime).
        Pessoa 2 quer: Estilo do encontro: \(user2SelectedStyle). Período do encontro: \(user2SelectedTime).
        Gere opções de encontro que agradem as duas pessoas, combinando essas preferências. Todas as respostas em pt BR.
    """
    }
}

//        Estilo do encontro: \(selectedStyleString). Período do encontro: \(selectedTimeString).
