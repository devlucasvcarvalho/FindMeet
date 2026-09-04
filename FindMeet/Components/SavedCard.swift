//
//  SavedCardsView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct SavedCardsView: View {
    
    let ideasColor: Color = Color(red: 255/255, green: 228/255, blue: 228/255)
    let buttonColor: Color = Color(red: 255/255, green: 183/255, blue: 183/255)
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(ideasColor))
                .frame(width: 370, height: 200)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 0)
            HStack{
                VStack{
                    Text("Titulo")
                        .font(.title.weight(.bold))
                    
                    Text("periodo")
                    
                    
                    Text("descrição")
                        .foregroundStyle(.gray)
                    
                    Button {
                        
                    } label: {
                        Text("Concluir")
                            .foregroundStyle(Color(.black))
                            .font(.system(size: 14, weight: .bold))
                            .padding(.horizontal, 80)
                            .padding(.vertical, 12)
                            .background(Color(buttonColor))
                            .clipShape(Capsule())
                    }
                }
                
                Image("cerejeart")
                    .resizable()
                    .scaledToFit()
                    .position(x: 100, y: 110)
                    .frame(width: 150, height: 150)
            }
                
        }
        //.shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}


#Preview {
    SavedCardsView()
}
