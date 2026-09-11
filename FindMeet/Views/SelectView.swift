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
    
    var backConfirmationTitle: String? = nil
    var backConfirmationMessage: String? = nil
    var onConfirmBack: (() -> Void)? = nil
       
    @State private var showBackConfirmation = false
    
    private let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text(step)
                    .font(.custom("Fredoka-Medium", size: 20))
                    .foregroundStyle(.secondary)
                
                Text(question)
                    .padding(20)
                    .font(.custom("Fredoka-Medium", size: 30))
                    .bold()
                    .multilineTextAlignment(.center)
                
                InfiniteCarouselView(
                    items: items,
                    selected: $selected
                )
                
                Button {
                    path.append(nextRoute)
                } label: {
                    HStack(spacing: 8) {
                        Text("Selecionar")
                            .font(.custom("Fredoka-Medium", size: 22))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.8)
                        
                        Image(systemName: "arrow.right")
                            .font(.custom("Fredoka-Medium", size: 22))
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: 250)
                    .padding(.vertical, 16)
                    .foregroundStyle(Color.white)
                    .background(Color(buttonColor))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .accessibilityLabel("Avançar")
                .padding(.horizontal, 30)
            }
        }
        .appBackground()
        .navigationBarBackButtonHidden(backConfirmationTitle != nil)
        .toolbar {
            if backConfirmationTitle != nil {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showBackConfirmation = true
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Fredoka-Medium", size: 20))
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .appPopup(isPresented: $showBackConfirmation) {
            PopUpview(
                icon: "exclamationmark.triangle.fill",
                title: backConfirmationTitle ?? "",
                message: backConfirmationMessage,
                secondaryButton: .init(label: "Cancelar", style: .secondary, action: {
                    showBackConfirmation = false
                }),
                primaryButton: .init(label: "Sair", style: .primary, action: {
                    showBackConfirmation = false
                    onConfirmBack?()
                }),
                onTapBackground: {
                    showBackConfirmation = false
                }
            )
        }
    }
}

// MARK: - Previews

#Preview("Estilo - Pessoa 1") {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectOptionView(
        path: $path,
        step: "1/2",
        question: "Qual atividade tem \n em mente?",
        items: MeetStyleEnum.allCases,
        selected: $flow.user1SelectedStyle,
        nextRoute: .selectTimeUser1
    )
}

#Preview("Horário - Pessoa 1") {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectOptionView(
        path: $path,
        step: "2/2",
        question: "Qual o melhor \nhorário?",
        items: MeetTimeEnum.allCases,
        selected: $flow.user1SelectedTime,
        nextRoute: .passPhone
    )
}
