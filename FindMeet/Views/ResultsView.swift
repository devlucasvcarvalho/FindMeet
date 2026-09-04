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
            // renderize a struct Suggestion aqui
            VStack{
                InfiniteCarousel(meets: [Meet:
                                        ])
            }
        } else {
            Text("Nenhuma sugestão disponível.")
        }
    }
}
