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
    @State private var isAnimating = false // 
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    Text("Qual a boa?")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.primary)
                        
                    
                    Button {
                        path.append(.notice)
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
                    
                case .notice:
                        NoticeView(
                            path: $path,
                            nextRoute: .selectStyleUser1 // <--- Ao clicar no botão, vai para a primeira pergunta
                        )
                    
                    case .selectStyleUser1:
                        SelectOptionView(
                            path: $path,
                                   step: "1/2",
                                   question: "Qual atividade tem \n em mente?",
                                   items: MeetStyleEnum.allCases,
                                   selected: $flow.user1SelectedStyle,
                                   nextRoute: .selectTimeUser1,
                                   // NOVO: as 3 linhas abaixo
                                   backConfirmationTitle: "Voltar para o início?",
                                   backConfirmationMessage: "Você vai perder os dados já preenchidos e voltar para a tela inicial.",
                                   onConfirmBack: { path.removeAll() }
                        )
                        
                    case .selectTimeUser1:
                        SelectOptionView(
                            path: $path,
                            step: "2/2",
                            question: "Qual o melhor \nhorário?",
                            items: MeetTimeEnum.allCases,
                            selected: $flow.user1SelectedTime,
                            nextRoute: .passPhone
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
                                    step: "1/2",
                                    question: "Sua vez! Qual atividade tem \n em mente?",
                                    items: MeetStyleEnum.allCases,
                                    selected: $flow.user2SelectedStyle,
                                    nextRoute: .selectTimeUser2,
                                    // NOVO: as 3 linhas abaixo
                                    backConfirmationTitle: "Tem certeza que deseja voltar??",
                                    backConfirmationMessage: "Isso irá fazer com que você volte para as perguntas do(a) seu parceiro",
                                    onConfirmBack: { path.removeLast(2) }
                        )
                        
                    case .selectTimeUser2:
                        SelectOptionView(
                            path: $path,
                            step: "2/2",
                            question: "Qual o melhor \nhorário?",
                            items: MeetTimeEnum.allCases,
                            selected: $flow.user2SelectedTime,
                            nextRoute: .loading
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
