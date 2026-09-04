//
//  ResultsView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct ResultsView: View {

    var flow: MeetFlowState

    var body: some View {
        if let suggestion = flow.suggestion {
            InfiniteCarousel(meets: suggestion.suggestions)
        } else {
            Text("Nenhuma sugestão disponível.")
        }
    }
}

// MARK: - Preview

//#Preview {
//    let flow = MeetFlowState()
//    flow.suggestion = Suggestion(suggestions: [
//        Meet(
//            title: "Praia no sábado",
//            description: "Manhã na praia para curtir o sol, o mar e a companhia um do outro.",
//            time: "Manhã",
//            ideas: ["Praia", "Bronze", "Sol"]
//        ),
//        Meet(
//            title: "Piquenique no domingo",
//            description: "Um piquenique à tarde para conversar e dividir lanches",
//            time: "Tarde",
//            ideas: ["Lanches", "Natureza", "Toalha"]
//        ),
//        Meet(
//            title: "Cinema a dois",
//            description: "Um cinema pertinho de casa, com filmes em lançamento, uma comédia romântica",
//            time: "Noite",
//            ideas: ["Pipoca", "Casaco", "Escolher juntos"]
//        )
//    ])
//    
//    return ResultsView(flow: flow)
//}
