//
//  GenerateMeetView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct GenerateMeetView: View {
    let backgroundColor: Color = Color(red: 250/255, green: 221/255, blue: 221/255)
    @State private var caminho = NavigationPath()
    var body: some View {
        NavigationStack(path: $caminho){
            ZStack{
                Color(backgroundColor)
                    .ignoresSafeArea(edges: .all)
                VStack{
                    Text("Qual a boa?")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    Button {
                        caminho.append("ir para InputView")
                    } label: {
                        HStack {
                            Image ("Mascote")
                        }   .scaledToFill()
                            .padding()
                        
                    }
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { valor in
                if valor == "ir para InputView" {
                    InputView()
                }
            }
        }
    }
}
#Preview {
    GenerateMeetView()
}
