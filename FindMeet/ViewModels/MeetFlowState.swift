//
//  LoadingViewModel.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

import Foundation
import Observation

@Observable
final class MeetFlowState {
    var selectedStyle: MeetStyleEnum = .gastronomic
    var selectedTime: MeetTimeEnum = .evening
    var suggestion: Suggestion?   // <- novo

    var selectedStyleString: String { selectedStyle.styles }
    var selectedTimeString: String { selectedTime.time }

    var promptQuery: String {
        "Estilo do encontro: \(selectedStyleString). Horário do encontro: \(selectedTimeString)."
    }
}
