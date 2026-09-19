//
//  CardDetailPreview.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 19/09/26.
//


//
//  CardDetailPreview.swift
//  FindMeet
//

import SwiftUI

struct CardDetailPreview: View {
    let card: Meet

    private let cardBackgroundColor = Color(red: 255/255, green: 228/255, blue: 228/255)

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {

                Text(card.title)
                    .font(.custom("Fredoka-SemiBold", size: 28))
                    .foregroundColor(.primary)

                Text("Durante a \(card.time)")
                    .font(.custom("Fredoka-Medium", size: 16))
                    .foregroundColor(.secondary)

                // MARK: Descrição
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardBackgroundColor)

                    Text(card.description)
                        .font(.custom("Fredoka-Regular", size: 16))
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
                    .font(.custom("Fredoka-SemiBold", size: 24))
                    .foregroundColor(.primary)

                // MARK: Dicas
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardBackgroundColor)

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(card.tips, id: \.self) { tip in
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.custom("Fredoka-SemiBold", size: 16))
                                    .foregroundColor(.black)

                                Text(tip)
                                    .font(.custom("Fredoka-Regular", size: 15))
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
            .padding(24)
        }
        .appBackground()
        .frame(width: 320, height: 480)
        
    }
}

#Preview {
    CardDetailPreview(
        card: Meet(
            title: "Cinema a dois",
            time: "noite",
            description: "Um cinema pertinho de casa, com filmes em lançamento, uma comédia romântica.",
            ideas: ["Pipoca", "Casaco", "Escolher juntos"],
            tips: ["Comprar ingresso antes", "Chegar cedo", "Escolher juntos", "Levar um casaco", "Combinar o lanche"]
        )
    )
}
