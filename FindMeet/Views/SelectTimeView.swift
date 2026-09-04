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
    
    var body: some View {
        VStack {
            Text("Qual o horário do encontro?")
                .font(.title2)
                .bold()
            
            // MARK: Carousel
            
            InfiniteCarouselView(
                items: MeetTimeEnum.allCases,
                selected: $flow.selectedTime
            )
            
            // MARK: Select Button
            
            Button {
                path.append(.loading)
            } label: {
                Text("Selecionar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.horizontal, 30)
            
            // MARK: Selected Value
            
            Text("Selecionado: \(flow.selectedTimeString)")
                .font(.subheadline)
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectTimeView(flow: flow, path: $path)
}
