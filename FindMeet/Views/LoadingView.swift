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

    @State private var errorMessage: String?
    @State private var isAnimating = false
    @Environment(\.dismiss) var dismiss
    @State private var showBackAlert = false

    private let generator: MeetGenerating = FoundationModelsMeetGenerator()
    private let primaryRed = Color(red: 0.58, green: 0.08, blue: 0.10)

    var body: some View {
        VStack {
            VStack(spacing: 24) {
                Image("feliz")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 380, maxHeight: 380)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Find")
                            Text("Meet")
                        }
                        .font(.custom("Fredoka-SemiBold", size: 50))
                        .foregroundColor(primaryRed)
                        .rotationEffect(.degrees(-12))
                        .offset(x: 80, y: -30)
                    }
                    .scaleEffect(isAnimating ? 1.04 : 0.96)
                    .animation(
                        .easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                    .padding(.horizontal, 30)

                Text("Gerando encontros que combinam com vocês.")
                    .font(.custom("Fredoka-Medium", size: 25))
                    .foregroundColor(primaryRed)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.top, 60)

            Spacer()
            Spacer()
        }
        .appBackground()
        .navigationBarBackButtonHidden(true)
        .onAppear { isAnimating = true }
        .task { await generateSuggestion() }
    }

    private func generateSuggestion() async {
        do {
            let result = try await generator.generateMeet(for: flow.promptQuery)
            flow.suggestion = result
            path.append(.results)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    @Previewable @State var samplePath: [MeetFlowRoute] = []

    LoadingView(
        flow: MeetFlowState(),
        path: $samplePath
    )
}
