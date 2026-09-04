//
//  InputView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct SelectStyleView: View {
    
    let backgroundColor: Color = Color(red: 250/255, green: 221/255, blue: 221/255)
    
    @Bindable var flow: MeetFlowState
    @Binding var path: [MeetFlowRoute]
    
    // Estilo que está atualmente selecionado no carrossel
    @State private var selectedStyle: MeetStyleEnum = .festive
    
    // String que será armazenada quando o usuário clicar em "Selecionar"
    @State private var selectedStyleString: String = ""
    
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 30) {
                
                Text("Qual o estilo do encontro?")
                    .padding(20)
                    .font(.title2)
                    .bold()
                // MARK: Carousel
                
                InfiniteCarouselInputView(
                    selectedStyle: $selectedStyle
                )
                
                
                // MARK: Current Carousel Selection
                
                //            Text("Opção atual: \(selectedStyle.styles)")
                //                .font(.headline)
                
                
                // MARK: Select Button
                
                Button {
                    
                    selectedStyleString = selectedStyle.styles
                    path.append(.selectTime)
                    
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
                
                if !selectedStyleString.isEmpty {
                    
                    Text(
                        "Selecionado: \(selectedStyleString)"
                    )
                    .font(.subheadline)
                }
            }
        }
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectStyleView(flow: flow, path: $path)
}
