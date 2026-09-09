//
//  GenerateMeetView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct GenerateMeetView: View {
    
    
    let backgroundColor: Color = Color(red: 250/255, green: 221/255, blue: 221/255)
    
    @State private var flow = MeetFlowState()
    @State private var path: [MeetFlowRoute] = []
    @State private var isAnimating = false // <--- Estado para a animação
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    Text("Qual a boa?")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.primary)
                        
                    
                    Button {
                        path.append(.selectStyleUser1)
                    } label: {
                        Image("cerejeart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 380)
                            .scaleEffect(isAnimating ? 1.04 : 0.96) // botao animado
                            .animation(
                                .easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                    }
                    .zIndex(0) // fica atrás
                    .accessibilityLabel("Criar encontro")
                    .accessibilityHint("Clique no botao para criar encontro")
                }
                .scaledToFill()
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MeetFlowRoute.self) { route in
                switch route {
                    // MARK: - Fluxo Pessoa 1
                    case .selectStyleUser1:
                        SelectOptionView(
                            path: $path,
                            step: "Pessoa 1 - 1/2",
                            question: "Qual atividade tem \n em mente?",
                            items: MeetStyleEnum.allCases,
                            selected: $flow.user1SelectedStyle, // <-- Variável da Pessoa 1
                            nextRoute: .selectTimeUser1         // <-- Próxima tela da Pessoa 1
                        )
                        
                    case .selectTimeUser1:
                        SelectOptionView(
                            path: $path,
                            step: "Pessoa 1 - 2/2",
                            question: "Qual o melhor \nhorário?",
                            items: MeetTimeEnum.allCases,
                            selected: $flow.user1SelectedTime, // <-- Variável da Pessoa 1
                            nextRoute: .passPhone              // <-- Manda para a tela de transição
                        )

                    // MARK: - Transição
                    case .passPhone:
                    PassPhoneView(
                        path: $path,
                        nextRoute: .selectStyleUser2
                    )

                    // MARK: - Fluxo Pessoa 2
                    case .selectStyleUser2:
                        SelectOptionView(
                            path: $path,
                            step: "Pessoa 2 - 1/2",
                            question: "Sua vez! Qual atividade tem \n em mente?",
                            items: MeetStyleEnum.allCases,
                            selected: $flow.user2SelectedStyle, // <-- Variável da Pessoa 2
                            nextRoute: .selectTimeUser2         // <-- Próxima tela da Pessoa 2
                        )
                        
                    case .selectTimeUser2:
                        SelectOptionView(
                            path: $path,
                            step: "Pessoa 2 - 2/2",
                            question: "Qual o melhor \nhorário?",
                            items: MeetTimeEnum.allCases,
                            selected: $flow.user2SelectedTime, // <-- Variável da Pessoa 2
                            nextRoute: .loading                // <-- Acabou! Vai gerar o encontro
                        )

                    // MARK: - Processamento e Resultados
                    case .loading:
                        LoadingView(flow: flow, path: $path)
                        
                    case .results:
                        ResultsView(flow: flow)
                    }
                    }
            }
//            .onAppear {
//                isAnimating = true 
//            }
        }
    }

#Preview {
    GenerateMeetView()
}
