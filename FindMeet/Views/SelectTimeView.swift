//
//  SelectTimeView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

import SwiftUI

struct SelectTimeView: View {
    
    @Bindable var flow: MeetFlowState
    @Binding var path: [MeetFlowRoute]
    // Estilo que está atualmente selecionado no carrossel
    @State private var selectedTime: MeetTimeEnum = .night
    
    // String que será armazenada quando o usuário clicar em "Selecionar"
    @State private var selectedTimeString: String = ""
    
    
    var body: some View {
        VStack {
            Text("Qual o horário do encontro?")
                .font(.title2)
                .bold()
            
            InfiniteCarouselView(
                items: MeetTimeEnum.allCases,
                selected: $flow.selectedTime
            )
            
            // MARK: Current Carousel Selection
            
            //            Text("Opção atual: \(selectedTime.styles)")
            //                .font(.headline)
            
            
            // MARK: Select Button
            
            Button {
                
                selectedTimeString = selectedTime.time
                path.append(.loading)
                
            } label: {
                
                Text("Selecionar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(
                        maxWidth: .infinity
                    )
                    .frame(height: 50)
                    .background(
                        Color.blue
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 15
                        )
                    )
            }
            .padding(.horizontal, 30)
            
            
            // MARK: Selected Value
            
            if !selectedTimeString.isEmpty {
                
                Text(
                    "Selecionado: \(selectedTimeString)"
                )
                .font(.subheadline)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectTimeView(flow: flow, path: $path)
}
