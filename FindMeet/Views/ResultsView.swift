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

    var body: some View {
        Group {
            if let suggestion = flow.suggestion {
                InfiniteCarousel(
                    meets: suggestion.suggestions,
                    onSelectDate: {
                        withAnimation { showConfirmPopup = true }
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
    }
}

#Preview {
    @Previewable @State var path: [MeetFlowRoute] = []
    @Previewable @State var selectedTab: Int = 0
    
    let flow = MeetFlowState()
    flow.suggestion = Suggestion(suggestions: [
        Meet(
            title: "Praia no sábado",
            time: "Manhã",
            description: "Manhã na praia para curtir o sol, o mar e a companhia um do outro.",
            ideas: ["Praia", "Bronze", "Sol"]
        ),
        Meet(
            title: "Piquenique no domingo",
            time: "Tarde",
            description: "Um piquenique à tarde para conversar e dividir lanches",
            ideas: ["Lanches", "Natureza", "Toalha"]
        ),
        Meet(
            title: "Cinema a dois",
            time: "Noite",
            description: "Um cinema pertinho de casa, com filmes em lançamento, uma comédia romântica",
            ideas: ["Pipoca", "Casaco", "Escolher juntos"]
        )
    ])
    
    return ResultsView(
        flow: flow,
        path: $path,
        selectedTab: $selectedTab
    )
}
