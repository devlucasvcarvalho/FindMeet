//
//  LoadingView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//


import SwiftUI

struct LoadingView: View {

    var flow: MeetFlowState
    @Binding var path: [MeetFlowRoute]

    @State private var suggestion: Suggestion?
    @State private var errorMessage: String?

    private let generator: MeetGenerating = FoundationModelsMeetGenerator()

    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Calculando o melhor encontro...")
        }
        .task {
            await generateSuggestion()
        }
    }

    private func generateSuggestion() async {
        do {
            let result = try await generator.generateMeet(for: flow.promptQuery)
            flow.suggestion = result
            path.append(.results)
        } catch {
            errorMessage = error.localizedDescription
            // trate o erro como quiser (retry, alerta, etc.)
        }
    }
}
