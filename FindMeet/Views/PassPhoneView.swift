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
    
    // Estado para controlar a troca de lado
    @State private var isSwapped = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    path.removeAll()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.custom("Fredoka-SemiBold", size: 18))
                        .foregroundColor(.primary)
                        .frame(width: 48, height: 48)
                        .background(buttonCircleColor)
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.horizontal, 24)
            
            Spacer()
            
            // Container para a animação
            ZStack {
                // Cereja de Óculos
                Image("eh")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190, height: 230)
                    .scaleEffect(isSwapped ? 0.9 : 1.1) // Zoom sutil para dar efeito de profundidade
                    .offset(
                        x: isSwapped ? 60 : -60,
                        y: isSwapped ? -15 : 20 // Deslocamento em Y diferenciado para criar arco
                    )
                    .zIndex(isSwapped ? 0 : 1)
                
                // Cereja Dormindo
                Image("humm")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 220)
                    .scaleEffect(isSwapped ? 1.1 : 0.9)
                    .offset(
                        x: isSwapped ? -60 : 60,
                        y: isSwapped ? 20 : -15
                    )
                    .zIndex(isSwapped ? 1 : 0)
            }
            .frame(width: 360, height: 300)
            .onAppear {
                // Animação mais rápida (0.8s) e contínua
                withAnimation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)
                ) {
                    isSwapped.toggle()
                }
            }
            
            Spacer()
            
            Text("Sua vez acabou!")
                .font(.custom("Fredoka-Medium", size: 35))
                .bold()
            
            Text("Passe o celular para a outra pessoa para que ela também possa escolher suas sugestões.")
                .font(.custom("Fredoka-Medium", size: 18))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                path.append(nextRoute)
            } label: {
                Text("Estou pronto!")
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
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
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
