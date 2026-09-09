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
                
                
                HStack {
                    Button {
                        path.removeAll() // Volta para a tela inicial
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: 48, maxHeight: 48)
                            .background(buttonCircleColor)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 24)
                
                //Spacer()
                
                // Ícone do SF Symbols corrigido (ou substitua por uma imagem do Assets ex: Image("SuaImagem"))
                Image("PassPhone")
                
                Text("Hora de Escolher!")
                    .font(.largeTitle)
                    .bold()
                
                Text("Decidam quem será o primeiro a selecionar as preferencias para o encontro. Mas atenção, para ficar mais divertido, não deixe a outra pessoa saber o que você escolheu! Depois, passaremos o celular para ela.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                //Spacer()
                
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
                .accessibilityHint("Clique para começar a escolher suas preferências!")
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
