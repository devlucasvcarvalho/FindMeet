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
     var selectedStyle: MeetStyleEnum = .festive
     var selectedTime: MeetTimeEnum = .evening
     var suggestion: Suggestion?   // <- novo
    
    var selectedStyleString: String { selectedStyle.styles }
    var selectedTimeString: String { selectedTime.time }
    
    var promptQuery: String {
        "Estilo do encontro: \(selectedStyleString). Período do encontro: \(selectedTimeString)."
    }
}
