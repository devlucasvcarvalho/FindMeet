//
//  CardsView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//
//perguntar como deixo um espaco especifico para cada componente do card

import SwiftUI

struct CardView: View {
    
    let index: Int
    let card: Meet
    var shadowRadius: CGFloat = 4.0
    
    let backgroundColor: Color = Color(red: 239/255, green: 182/255, blue: 182/255)
    let ideasColor: Color = Color(red: 255/255, green: 228/255, blue: 228/255)
    let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(spacing: 16) {
            
            // MARK: Header
            
            HStack {
                Text("Opção \(index + 1)")
                    .font(.title.weight(.bold))
                
                Image("cerejinhas")
                    .accessibilityHidden(true)
            }
            
            // MARK: Title & Time
            
            VStack {
                Text(card.title)
                    .font(.title2.weight(.bold))
                
                Spacer()
                
                Text("Durante a \(card.time)")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
            .accessibilityElement(children: .combine)
            
            // MARK: Description
            
            ScrollView {
                Text(card.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 200, height: 65)
            
            // MARK: Ideas
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(card.ideas, id: \.self) { idea in
                        Text(idea)
                            .font(.system(.subheadline, weight: .semibold))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 6)
                            .background(ideasColor)
                            .clipShape(Capsule())
                    }
                }
            }
            .accessibilityLabel("Ideias inclusas: \(card.ideas.joined(separator: ", "))")
            .accessibilityElement(children: .ignore)
            
            // MARK: Select Button
            
            Button {
                
            } label: {
                Text("Escolher date")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.bold))
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 44)
                    .background(buttonColor)
                    .clipShape(Capsule())
            }
            .accessibilityLabel("Escolher date")
            .accessibilityHint("Confirma a seleção da opção \(card.title)")
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(backgroundColor)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 10, y: 10)
        )
        .padding(.horizontal)
        .frame(maxWidth: 250, maxHeight: 350)
    }
}

// MARK: - Preview

//#Preview {
//    CardView(
//        index: 0,
//        card: Meet(
//            title: "Praia no sábado",
//            description: "Manhã na praia para curtir o sol, o mar e a companhia um do outro.", time: "Noite", time: <#String#>
//            ideas: ["Praia", "Bronze", "Sol"]
//        )
//    )
//}
