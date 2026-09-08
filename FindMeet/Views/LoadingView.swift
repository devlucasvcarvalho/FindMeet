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
    private let buttonCircleColor = Color.black.opacity(0.05)

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .background(buttonCircleColor)
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Image("gerando")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    )
            }
            .padding(.top, 10)
            .padding(.horizontal, 24)
            
            Spacer()
            
            VStack(spacing: 40) {
                Text("Gerando ideias de\ndate")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                Image("gerando3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360, height: 300)
                    .offset(x: 12)
                    .scaleEffect(isAnimating ? 1.04 : 0.96)
                    .animation(
                        .easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
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
