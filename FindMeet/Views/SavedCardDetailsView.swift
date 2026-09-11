//
//  SavedCardDetailsView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 10/09/26.
//

import SwiftUI

struct CardDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let card: SavedData
    
    let tips: [String] = [
        "Escolham o filme juntos antes de sair.",
        "Comprem os ingressos antecipadamente.",
        "Dividam uma pipoca ou escolham o lanche favorito de cada um.",
        "Cheguem um pouco antes para não perder os trailers.",
        "Depois do filme, parem em algum lugar para conversar sobre ele."
    ]
    private let cardBackgroundColor = Color(red: 255/255, green: 228/255, blue: 228/255)
    private let buttonCircleColor = Color.black.opacity(0.05)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Button {
                        dismiss()
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
                
                Text(card.title)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardBackgroundColor)
                    
                    Text(card.descriptions)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.black)
                        .lineSpacing(4)
                        .padding(20)
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("Mascote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .offset(x: 5, y: 10)
                }
                
                Text("Dicas")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardBackgroundColor)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(tips, id: \.self) { tip in
                            HStack(alignment: .top, spacing: 8) {
                                Text("•")
                                    .font(.system(size: 16, weight: .bold))
                                Text(tip)
                                    .font(.system(size: 15, design: .rounded))
                                    .foregroundColor(.black)
                                    .lineSpacing(3)
                            }
                        }
                    }
                    .padding(20)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("Mascote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .offset(x: 5, y: 10)
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
        }
        .appBackground()
        .ignoresSafeArea(edges: .all)
        .navigationBarBackButtonHidden(true)
    }
}
