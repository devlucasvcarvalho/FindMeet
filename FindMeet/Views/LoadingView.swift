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

    private let generator: MeetGenerating = FoundationModelsMeetGenerator()
    private let primaryRed = Color(red: 0.58, green: 0.08, blue: 0.10)

    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            .padding(.top, 16)
            .padding(.trailing, 24)

            Spacer()
            Spacer()

            VStack(spacing: 24) {
                ZStack(alignment: .topLeading) {
                    Image("feliz")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 380, height: 380)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Find")
                            .font(.custom("Fredoka-SemiBold", size: 50))
                        Text("Meet")
                            .font(.custom("Fredoka-SemiBold", size: 50))
                    }
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
                .padding(30)

                Text("Gerando encontros que combinam\ncom vocês.")
                    .font(.custom("Fredoka-Medium", size: 25))
                    .foregroundColor(primaryRed)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)

            Spacer()
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isAnimating = true
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
