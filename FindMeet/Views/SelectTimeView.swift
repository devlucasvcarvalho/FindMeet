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
    @State private var currentPage = 0
    let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    
    var body: some View {
        VStack {
            Text("Qual o horário do encontro?")
                .font(.title2)
                .bold()
            
            // MARK: Carousel
            // Toque num card já seleciona (destaque + checkmark aparecem ali dentro);
            // o usuário pode tocar em outro pra trocar livremente antes de avançar.
            InfiniteCarouselView(
                items: MeetTimeEnum.allCases,
                selected: $flow.selectedTime
            )
            
            // MARK: Advance Button
            // Só avança pra próxima pergunta — não seleciona nada, a seleção
            // já aconteceu ao tocar no carrossel acima.
            Button {
                path.append(.loading)
            } label: {
//                Image(systemName: "arrow.right.circle.fill")
//                    .font(.system(size: 44))
//                    .foregroundStyle(.white, Color.blue)
            }
            .accessibilityLabel("Avançar")
            .accessibilityHint("Confirma \(flow.selectedTimeString) e vai para a próxima pergunta")
            .padding(.top, 20)
            HStack {
                Button(action: {
                    let allItems = MeetTimeEnum.allCases
                            // Encontra o índice atual
                            if let currentIndex = allItems.firstIndex(of: flow.selectedTime) {
                                // Calcula o índice anterior (com lógica circular)
                                let prevIndex = (currentIndex - 1 + allItems.count) % allItems.count
                                flow.selectedTime = allItems[prevIndex]
                            }
                }) {
                    Image(systemName: "arrow.left")
                        .frame(maxWidth: 60, maxHeight: 60)
                        .font(.system(.title, design: .rounded, ))
                        .foregroundStyle(Color.white)
                        .background(
                            Color(buttonColor)
                        )
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                }
                
                
                Spacer()
           Button(action: {
               let allItems = MeetTimeEnum.allCases
                       // Encontra o índice atual
                       if let currentIndex = allItems.firstIndex(of: flow.selectedTime) {
                           // Calcula o próximo índice (com lógica circular)
                           let nextIndex = (currentIndex + 1) % allItems.count
                           flow.selectedTime = allItems[nextIndex]
                       }
            }) {
                Image(systemName: "arrow.right")
                    .frame(maxWidth: 60, maxHeight: 60)
                    .font(.system(.title2, design: .rounded, weight:.bold))
                    .foregroundStyle(Color.white)
                    .background(
                        Color(buttonColor)
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
            }
                
                
            }
            .padding(20)

            .padding(.horizontal, 30)

        }
        
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectTimeView(flow: flow, path: $path)
}
