//
//  SavedCardsView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct SavedCardsView: View {
    
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    var onClonclude: (() -> Void)? = nil
    
    let ideasColor: Color = Color(red: 255/255, green: 228/255, blue: 228/255)
    let buttonColor: Color = Color(red: 255/255, green: 183/255, blue: 183/255)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 24)
                .fill(ideasColor)
                        
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(subtitle)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(description)
                    .font(.system(size: 15, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false , vertical: true)
                    .frame(maxWidth: 200, alignment: .leading)
                
                Spacer(minLength: 8)
                
                Button {
                    onClonclude?()
                } label: {
                    Text("Concluir")
                        .foregroundStyle(Color.black)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(buttonColor)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.black, lineWidth: 1.5)
                        )
                }
                .frame(width: 180)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("Mascote")
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .offset(x: -8, y: -8)
        }
        .frame(width: 360, height: 210)
    }
}

#Preview {
    SavedCardsView(
        title: "Cinema em Casa",
        subtitle: "2,4km • Á noite",
        description: "Um cinema pertinho de casa, com filmes em lançamento",
        imageName: "Mascote"
    )
}
