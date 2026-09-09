//
//  SelectView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 09/09/26.
//

import SwiftUI

struct SelectOptionView<T: CarouselItem>: View {
    
    @Binding var path: [MeetFlowRoute]
    
    
    let step: String
    let question: String
    let items: [T]
    @Binding var selected: T
    let nextRoute: MeetFlowRoute  
    
    private let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text(step)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Text(question)
                    .padding(20)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                InfiniteCarouselView(
                    items: items,
                    selected: $selected
                )
                
                HStack {
                    Spacer()
                    
                    Button {
                        path.append(nextRoute)
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .padding(16)
                            .background(Color(buttonColor))
                            .clipShape(Circle())
                            .shadow(color: Color.white.opacity(0.2),
                                    radius: 10,
                                    x: 0, y: 5)
                    }
                    .accessibilityLabel("Avançar")
                }
                .padding(.horizontal, 30)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Previews

//#Preview("Estilo") {
//    @Previewable @State var flow = MeetFlowState()
//    @Previewable @State var path: [MeetFlowRoute] = []
//    
//    SelectOptionView(
//        path: $path,
//        step: "1/2",
//        question: "Qual atividade tem \n em mente?",
//        items: MeetStyleEnum.allCases,
//        selected: $flow.selectedStyle,
//        nextRoute: .selectTime
//    )
//}

// MARK: - Previews

#Preview("Estilo - Pessoa 1") {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectOptionView(
        path: $path,
        step: "Pessoa 1 - 1/2",
        question: "Qual atividade tem \n em mente?",
        items: MeetStyleEnum.allCases,
        selected: $flow.user1SelectedStyle,      // Atualizado para a variável da Pessoa 1
        nextRoute: .selectTimeUser1     // Atualizado para a nova rota
    )
}

#Preview("Horário - Pessoa 1") {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectOptionView(
        path: $path,
        step: "Pessoa 1 - 2/2",
        question: "Qual o melhor \nhorário?",
        items: MeetTimeEnum.allCases,
        selected: $flow.user1SelectedTime ,       // Atualizado para a variável da Pessoa 1
        nextRoute: .passPhone            // Atualizado para a rota de passar o celular
    )
}
