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
    private let buttonCircleColor = Color.black.opacity(0.05)

    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        showBackAlert = true
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .font(.custom("Fredoka-Medium", size: 20))
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .background(buttonCircleColor)
                        .clipShape(Circle())
                }
                
                Spacer()
            }
            .padding(.top, 10)
            .padding(.horizontal, 24)
            
            Spacer()
            
            VStack(spacing: 40) {
                Text("Gerando ideias de\ndate")
                    .font(.custom("Fredoka-SemiBold", size: 35))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                Image("gerando")
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
        .appPopup(isPresented: $showBackAlert) {
                    PopUpview(
                        icon: "exclamationmark.triangle.fill",
                        title: "Voltar para a seleção?",
                        message: "Tem certeza que deseja voltar para a tela de seleção de horário?",
                        secondaryButton: .init(label: "Cancelar", style: .secondary, action: {
                            withAnimation { showBackAlert = false }
                        }),
                        primaryButton: .init(label: "Voltar", style: .primary, action: {
                            withAnimation { showBackAlert = false }
                            // Remove a tela de loading do path, retornando para .selectTimeUser2
                            path.removeLast()
                        }),
                        onTapBackground: {
                            withAnimation { showBackAlert = false }
                        }
                    )
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
