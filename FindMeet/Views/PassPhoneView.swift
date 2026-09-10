//
//  PassPhoneView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 09/09/26.
//

import SwiftUI

struct PassPhoneView: View {
    @Binding var path: [MeetFlowRoute]
    let nextRoute: MeetFlowRoute
    
    @Environment(\.dismiss) var dismiss
    private let buttonCircleColor = Color.black.opacity(0.05)
    
    private let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
            Button {
                path.removeAll()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 48, height: 48)
                    .background(buttonCircleColor)
                    .clipShape(Circle())
                }
            Spacer() // Empurra o botão para a esquerda
        }
                    .padding(.top, 10)
                    .padding(.horizontal, 24)
                        
            Spacer()
            
            Image("PassPhone")
                .font(.system(size: 80))
                .foregroundColor(buttonColor)
            
            Text("Sua vez acabou!")
                .font(.largeTitle)
                .bold()
            
            Text("Passe o celular para a outra pessoa para que ela também possa escolher suas sugestões.")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                path.append(nextRoute)
            } label: {
                Text("Estou pronto!")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 30)
            }
            .padding(.bottom, 40)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true) // Evita que a pessoa 2 volte e mude a da pessoa 1 facilmente
    }
}
// MARK: - Previews

#Preview("Passar Celular") {
    @Previewable @State var path: [MeetFlowRoute] = []
    
    PassPhoneView(
        path: $path,
        nextRoute: .selectStyleUser2
    )
}
