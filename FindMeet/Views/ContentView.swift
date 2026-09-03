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
            //Puxar view inicial
                TelaView()
                .ignoresSafeArea()
        case .unavailable(let reason):
            let text = switch reason {
            case .appleIntelligenceNotEnabled:
                "Apple Intelligence is not enabled. Please enable it in Settings."
            case .deviceNotEligible:
                "This device is not eligible for Apple Intelligence. Please use a compatible device."
            case .modelNotReady:
                "The language model is not ready yet. Please try again later."
            @unknown default:
                "The language model is unavailable for an unknown reason."
            }
            ContentUnavailableView(text, systemImage: "apple.intelligence.badge.xmark")
        }
    }
}

#Preview {
    ContentView()
}
