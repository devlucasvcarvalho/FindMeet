//
//  NoticeView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 09/09/26.
//

import SwiftUI

struct NoticeView: View {
    @Binding var path: [MeetFlowRoute]
    let nextRoute: MeetFlowRoute
    
    @Environment(\.dismiss) var dismiss
    @State private var isVisible = false
    private let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    private let buttonCircleColor = Color.black.opacity(0.05)
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                Button {
                    path.removeAll()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.custom("Fredoka-Medium", size: 20))
                        .foregroundColor(.black)
                        .frame(maxWidth: 48, maxHeight: 48)
                        .background(buttonCircleColor)
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.horizontal, 24)
            
            Image("escolher")
            
            Text("Hora de Escolher!")
                .font(.custom("Fredoka-Medium", size: 35))
                .bold()
            
            Text("Decidam quem será o primeiro a selecionar as preferencias para o encontro. Mas atenção, para ficar mais divertido, não deixe a outra pessoa saber o que você escolheu! Depois, passe o celular para ela.")
                .font(.custom("Fredoka-Medium", size: 19))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 30)
            
            Button {
                path.append(nextRoute)
            } label: {
                Text("Vamos lá!")
                    .font(.custom("Fredoka-Medium", size: 20))
                    .padding()
                    .foregroundStyle(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                    .background(buttonColor)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 40)
        }
        .appBackground()
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 50)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8))  {
                isVisible = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Previews

#Preview("Aviso Pessoa 1") {
    @Previewable @State var path: [MeetFlowRoute] = []
    
    NavigationStack {
        NoticeView(
            path: $path,
            nextRoute: .selectStyleUser1
        )
    }
}
