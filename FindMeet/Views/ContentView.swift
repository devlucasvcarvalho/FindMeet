//
//  ContentView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 26/08/26.
//

import SwiftUI
import SwiftData
import FoundationModels

struct ContentView: View {
    var body: some View {
        switch SystemLanguageModel.default.availability {
        case .available:
//            //Puxar view inicial
            GenerateMeetView(selectedTab: .constant(0))
                .ignoresSafeArea()
        case .unavailable(let reason):
            switch reason {
            
            case .appleIntelligenceNotEnabled:
                NotEnabledView()
            case .deviceNotEligible:
                NotEligibleView()
            case .modelNotReady:
                NotReadyView()
            @unknown default:
                UnknownReasonView()
            }
        }
    }
}


#Preview {
    ContentView()
}
