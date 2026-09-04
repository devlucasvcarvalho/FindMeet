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
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    Text("Qual a boa?")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    
                    Button {
                        path.append(.selectStyle)
                    } label: {
                        Image("cerejeart")
                            .padding()
                            .scaledToFit()
                            .frame(width: 300, height: 400)
                    }
                    .accessibilityLabel("Criar encontro")
                    .accessibilityHint("Clique no botao para criar encontro")
                }
                .scaledToFill()
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MeetFlowRoute.self) { route in
                switch route {
                case .selectStyle:
                    SelectStyleView(flow: flow, path: $path)
                case .selectTime:
                    SelectTimeView(flow: flow, path: $path)
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
