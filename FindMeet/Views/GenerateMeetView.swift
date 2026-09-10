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
    
    @State private var isExpanded = false
    @State private var isPulsing = false
    @State private var showTapHint = false
    
    private var shouldShowTabBar: Bool {
        path.isEmpty || path.last == .results
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack(spacing: 0) {
                    Spacer().frame(height: isExpanded ? 40 : 0)
                    
                    Text(isExpanded ? "Qual a boa?" : "Find\nMeet")
                        .font(.system(size: isExpanded ? 38 : 52, weight: .black, design: .rounded))
                        .foregroundColor(isExpanded ? .primary : Color(red: 144/255, green: 3/255, blue: 3/255))
                        .multilineTextAlignment(.center)
                        .rotationEffect(.degrees(isExpanded ? 0 : -8))
                        .offset(x: isExpanded ? 0 : -70, y: isExpanded ? 0 : 110)
                        .zIndex(1)
                        .animation(.spring(response: 0.45, dampingFraction: 0.7), value: isExpanded)
                    
                    Spacer()
                    
                    Image(isExpanded ? "cerejeart" : "feliz")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: isExpanded ? 340 : 320,
                            height: isExpanded ? 400 : 390
                        )
                        .scaleEffect(isPulsing ? 1.06 : 1.0)
                        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: isPulsing)
                        .scaleEffect(isExpanded ? 1.05 : 1.0)
                        .animation(.spring(response: 0.45, dampingFraction: 0.7), value: isExpanded)
                        .offset(y: isExpanded ? -80 : -35)
                        .onTapGesture {
                            if isExpanded {
                                path.append(MeetFlowRoute.notice)
                            }
                        }
                        .accessibilityLabel("Criar encontro")
                        .accessibilityHint("Clique no botão para criar encontro")
                    
                    if showTapHint {
                        Text("Clique na cereja")
                            .font(.subheadline.bold())
                            .foregroundColor(.secondary)
                            .transition(.opacity)
                    }
                    
                    Spacer()
                    
                    // Subtítulo
                    if !isExpanded {
                        Text("Encontros que combinam\ncom vocês.")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                            .multilineTextAlignment(.center)
                            .transition(.opacity)
                            .offset(y: -90)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(shouldShowTabBar ? .visible : .hidden, for: .tabBar)
            .task {
                isExpanded = false
                isPulsing = false
                showTapHint = false
                
                isPulsing = true  // já anima sozinho via .animation(value: isPulsing)
                
                try? await Task.sleep(nanoseconds: 1_500_000_000)
                guard !Task.isCancelled else { return }
                isExpanded = true  // já anima sozinho via .animation(value: isExpanded)
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                guard !Task.isCancelled else { return }
                withAnimation(.easeIn) {
                    showTapHint = true
                }
            }            .navigationDestination(for: MeetFlowRoute.self) { route in
                switch route {
                    // MARK: - Fluxo Pessoa 1
                case .notice:
                    NoticeView(
                        path: $path,
                        nextRoute: .selectStyleUser1
                    )
                    
                case .selectStyleUser1:
                    SelectOptionView(
                        path: $path,
                        step: "1/2",
                        question: "Qual atividade tem \n em mente?",
                        items: MeetStyleEnum.allCases,
                        selected: $flow.user1SelectedStyle,
                        nextRoute: .selectTimeUser1
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
                        nextRoute: .selectTimeUser2
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
    }
}

#Preview {
    GenerateMeetView()
}
