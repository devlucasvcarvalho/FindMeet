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
        
        private let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
        private let buttonCircleColor = Color.black.opacity(0.05)
        
        var body: some View {
            VStack(spacing: 30) {
                
                // MARK: - Botão de Voltar (Topo)
                HStack {
                    Button {
                        path.removeAll() // Volta para a tela inicial
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(buttonCircleColor)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Ícone do SF Symbols corrigido (ou substitua por uma imagem do Assets ex: Image("SuaImagem"))
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(buttonColor)
                
                Text("Sua vez, Pessoa 1!")
                    .font(.largeTitle)
                    .bold()
                
                Text("Escolha suas preferências para o date sem deixar a outra pessoa ver.\n\nDepois, passaremos o celular para ela.")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                Button {
                    path.append(nextRoute)
                } label: {
                    Text("Vamos lá!")
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
            .navigationBarBackButtonHidden(true)
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
