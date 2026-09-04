//
//  FlowRootView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

//
import SwiftUI

enum MeetFlowRoute: Hashable {
    case selectStyle
    case selectTime
    case loading
    case results
}


struct MeetFlowRootView: View {

    @State private var flow = MeetFlowState()
    @State private var path: [MeetFlowRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            SelectStyleView(flow: flow, path: $path)
                .navigationDestination(for: MeetFlowRoute.self) { route in
                    switch route {
                    case .selectTime:
                        SelectTimeView(flow: flow, path: $path)
                    case .loading:
                        LoadingView(flow: flow, path: $path)
                    case .results:
                        ResultsView(flow: flow)
                    case .selectStyle:
                        SelectStyleView(flow: flow, path: $path)
                    }
                }
        }
    }
}
