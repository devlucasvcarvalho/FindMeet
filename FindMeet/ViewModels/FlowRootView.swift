//
//  FlowRootView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

//
//import SwiftUI
//
enum MeetFlowRoute: Hashable {
    
    //primeiro usuario
    case selectStyleUser1
    case selectTimeUser1
    //segundo usuario
    case selectStyleUser2
    case selectTimeUser2
    
    case passPhone //para avisar para avisar ao proximo usuario
    
    case loading
    case results
}

//struct MeetFlowRootView: View {
//
//    @State private var flow = MeetFlowState()
//    @State private var path: [MeetFlowRoute] = []
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            SelectStyleView(flow: flow, path: $path)
//                .navigationDestination(for: MeetFlowRoute.self) { route in
//                    switch route {
//                    case .selectTime:
//                        SelectTimeView(flow: flow, path: $path)
//                    case .loading:
//                        LoadingView(flow: flow, path: $path)
//                    case .results:
//                        ResultsView(flow: flow)
//                    case .selectStyle:
//                        SelectStyleView(flow: flow, path: $path)
//                    }
//                }
//        }
//    }
//}
