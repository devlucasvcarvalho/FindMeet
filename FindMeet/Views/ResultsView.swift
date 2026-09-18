//
//  ResultsView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//
import SwiftUI

struct ResultsView: View {

    var flow: MeetFlowState
    @Binding var path: [MeetFlowRoute]
    @Binding var selectedTab: Int
    
    @State private var showConfirmPopup = false
    @State private var showAlreadySavedPopup = false

    var body: some View {
        Group {
            if let suggestion = flow.suggestion {
                InfiniteCarousel(
                    meets: suggestion.suggestions,
                    onSelectDate: { wasAlreadySaved in
                        withAnimation {
                            if wasAlreadySaved {
                                showAlreadySavedPopup = true
                            } else {
                                showConfirmPopup = true
                            }
                        }
                    }
                )
            } else {
                Text("Nenhuma sugestão disponível.")
            }
        }
        .appBackground()
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeAll()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.black)
                }
            }
        }
        .appPopup(isPresented: $showConfirmPopup) {
            PopUpview(
                title: "Date escolhido!",
                message: "O que você quer fazer agora?",
                secondaryButton: .init(label: "Ver salvos", style: .secondary, action: {
                    withAnimation { showConfirmPopup = false }
                    path.removeAll()
                    selectedTab = 1
                }),
                primaryButton: .init(label: "Tela inicial", style: .primary, action: {
                    withAnimation { showConfirmPopup = false }
                    path.removeAll()
                }),
                tertiaryButton: .init(label: "Salvar mais ideias", style: .secondary, action: {
                    withAnimation { showConfirmPopup = false }
                }),
                onTapBackground: {
                    withAnimation { showConfirmPopup = false }
                }
            )
        }
        .appPopup(isPresented: $showAlreadySavedPopup) {
                PopUpview(
                    icon: "checkmark.circle.fill",
                    title: "Já salvo!",
                    message: "Essa opção já está na sua lista de encontros salvos.",
                    secondaryButton: .init(label: "Fechar", style: .secondary, action: {
                        withAnimation { showAlreadySavedPopup = false }
                    }),
                    primaryButton: .init(label: "Ver salvos", style: .primary, action: {
                        withAnimation { showAlreadySavedPopup = false }
                        path.removeAll()
                        selectedTab = 1
                    }),
                    onTapBackground: {
                        withAnimation { showAlreadySavedPopup = false }
                    }
                )
            }
        }
}

#Preview {
    @Previewable @State var path: [MeetFlowRoute] = []
    @Previewable @State var selectedTab: Int = 0
    
    // 1. Configura o objeto dentro de uma closure para funcionar no ViewBuilder
    let flow: MeetFlowState = {
        let state = MeetFlowState()
        state.suggestion = Suggestion(suggestions: [
            Meet(
                title: "Praia no sábado",
                time: "Manhã",
                description: "Manhã na praia para curtir o sol, o mar e a companhia um do outro.",
                ideas: ["Praia", "Bronze", "Sol"],
                tips: ["", "", ""]
            ),
            Meet(
                title: "Piquenique no domingo",
                time: "Tarde",
                description: "Um piquenique à tarde para conversar e dividir lanches",
                ideas: ["Lanches", "Natureza", "Toalha"],
                tips: ["", "", ""]
            ),
            Meet(
                title: "Cinema a dois",
                time: "Noite",
                description: "Um cinema pertinho de casa, com filmes em lançamento, uma comédia romântica",
                ideas: ["Pipoca", "Casaco", "Escolher juntos"],
                tips: ["", "", ""]
            )
        ])
        return state
    }()
    
    // 2. NavigationStack para a toolbar e navegação funcionarem no Preview
    NavigationStack {
        ResultsView(
            flow: flow,
            path: $path,
            selectedTab: $selectedTab
        )
    }
}
