//
//  CardsView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//


import SwiftUI

struct CardView: View {
    let card: Meet
    var shadowRadius: CGFloat = 4.0
    let backgroundColor: Color = Color(red: 239/255, green: 182/255, blue: 182/255)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(backgroundColor)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)

            VStack(spacing: 16) {
                Text(card.title)
                    .font(.title2.weight(.bold))

                Text(card.description)
                    .font(.subheadline)

                ForEach(card.ideas, id: \.self) { idea in
                    Text(idea)
                        .font(.body)
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 250, height: 350)
    }
}

#Preview {
    CardView(card: Meet(title: "Picnic", description: "Parque", tip:"Filme", ideas: ["1", "2", "3"]))
}
