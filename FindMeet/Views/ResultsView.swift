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
        .ignoresSafeArea(edges: .all)
        .toolbar(.hidden, for: .tabBar)
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
