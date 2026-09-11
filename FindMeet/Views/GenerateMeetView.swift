//
//  GenerateMeetView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//
import SwiftUI

struct GenerateMeetView: View {

    @Binding var selectedTab: Int
    @State private var flow = MeetFlowState()
    @State private var path: [MeetFlowRoute] = []
    @State private var showHome = AppSessionState.hasShownLaunchIntro
    @State private var showTapHint = false

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if showHome {
                    homeContent
                } else {
                    IntroSplashView {
                        showHome = true
                        showTapHint = true // já mostra o hint direto, sem esperar de novo
                    }
                }
            }
            .navigationDestination(for: MeetFlowRoute.self) { route in
                switch route {

                case .notice:
                    NoticeView(
                        path: $path,
                        nextRoute: .selectStyleUser1
                    )
                    .toolbar(.hidden, for: .tabBar)

                case .selectStyleUser1:
                    SelectOptionView(
                        path: $path,
                        step: "1/2",
                        question: "Qual atividade tem \n em mente?",
                        items: MeetStyleEnum.allCases,
                        selected: $flow.user1SelectedStyle,
                        nextRoute: .selectTimeUser1,
                        backConfirmationTitle: "Voltar para o início?",
                        backConfirmationMessage: "Você vai perder os dados já preenchidos e voltar para a tela inicial.",
                        onConfirmBack: { path.removeAll() }
                    )
                    .toolbar(.hidden, for: .tabBar)

                case .selectTimeUser1:
                    SelectOptionView(
                        path: $path,
                        step: "2/2",
                        question: "Qual o melhor \nhorário?",
                        items: MeetTimeEnum.allCases,
                        selected: $flow.user1SelectedTime,
                        nextRoute: .passPhone
                    )
                    .toolbar(.hidden, for: .tabBar)

                case .passPhone:
                    PassPhoneView(
                        path: $path,
                        nextRoute: .selectStyleUser2
                    )
                    .toolbar(.hidden, for: .tabBar)

                case .selectStyleUser2:
                    SelectOptionView(
                        path: $path,
                        step: "1/2",
                        question: "Sua vez! Qual atividade tem \n em mente?",
                        items: MeetStyleEnum.allCases,
                        selected: $flow.user2SelectedStyle,
                        nextRoute: .selectTimeUser2,
                        backConfirmationTitle: "Tem certeza que deseja voltar??",
                        backConfirmationMessage: "Isso irá fazer com que você volte para as perguntas do(a) seu parceiro",
                        onConfirmBack: { path.removeLast(2) }
                    )
                    .toolbar(.hidden, for: .tabBar)

                case .selectTimeUser2:
                    SelectOptionView(
                        path: $path,
                        step: "2/2",
                        question: "Qual o melhor \nhorário?",
                        items: MeetTimeEnum.allCases,
                        selected: $flow.user2SelectedTime,
                        nextRoute: .loading
                    )
                    .toolbar(.hidden, for: .tabBar)

                case .loading:
                    LoadingView(flow: flow, path: $path)
                        .toolbar(.hidden, for: .tabBar)

                case .results:
                    ResultsView(flow: flow, path: $path, selectedTab: $selectedTab)
                        .toolbar(.visible, for: .tabBar)
                }
            }
        }
    }

    @ViewBuilder
    private var homeContent: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)

            Text("Qual a boa?")
                .font(.system(size: 38, weight: .black, design: .rounded))
                .multilineTextAlignment(.center)
                .zIndex(1)

            Spacer()

            Image("cerejeart")
                .resizable()
                .scaledToFit()
                .frame(width: 340, height: 400)
                .scaleEffect(1.05)
                .offset(y: -80)
                .onTapGesture {
                    path.append(.notice)
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
        }
        .padding()
        .appBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .tabBar)
        .task {
            // só espera se ainda não veio da splash com o hint já ativo
            guard !showTapHint else { return }
            try? await Task.sleep(nanoseconds: 300_000_000)
            withAnimation(.easeIn) {
                showTapHint = true
            }
        }
    }
}

#Preview {
    GenerateMeetView(selectedTab: .constant(0))
}
