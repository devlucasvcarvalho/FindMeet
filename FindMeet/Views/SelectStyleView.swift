//
//  InputView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct SelectStyleView: View {
    
    // Estilo que está atualmente selecionado no carrossel
    @State private var selectedStyle: MeetStyleEnum = .gastronomic
    
    // String que será armazenada quando o usuário clicar em "Selecionar"
    @State private var selectedStyleString: String = ""
    
    
    var body: some View {
        
        VStack(spacing: 30) {
            
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


// MARK: - Preview

#Preview {
    SelectStyleView()
}
