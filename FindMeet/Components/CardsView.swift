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
//        ZStack {
//            RoundedRectangle(cornerRadius: 60)
//                .fill(backgroundColor)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//
////            ScrollView {
                content
//                   // .padding(.top, 30)
//            //}
//        }
//        .frame(width: 250, height: 350)
    }
    
    var content: some View {
        VStack(spacing: 16) {
            
            //Text("Opção \(index + 1)") + Text(Image("cerejinhas"))
             //   .font(.title2.weight(.bold))
            HStack{
                Text("Opção \(index + 1)")
                    .font(.title.weight(.bold))
                    
                    
                Image("cerejinhas")
                    .accessibilityHidden(true)
            }
            VStack{
                Text(card.title)
                    .font(.title2.weight(.bold))
                Spacer()
                Text("Durante a \(card.time)")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                
            }
            .accessibilityElement(children: .combine)
           
            
            ScrollView{
                Text(card.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.secondary)
            }
           // .scaledToFit()
                .frame(width: 200, height:65)
            
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack{
                    ForEach(card.ideas, id: \.self) { idea in
                        Text(idea)
                            .font(.system(.subheadline, weight: .semibold))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 6)
                            .background(Color(ideasColor))
                            .clipShape(Capsule())
                    }
                }
            }
            .accessibilityLabel("Ideias inclusas: \(card.ideas.joined(separator: ", "))")
                        .accessibilityElement(children: .ignore)
           
            Button {
                
            } label: {
                Text("Escolher date")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.bold)) // Usa Dynamic Type
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 44) // Área mínima de toque recomendada pela Apple
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
        .frame(maxWidth: 250, maxHeight: 350) // Permite encolher em telas pequenas e limita o crescimento em telas grandes
    }
}

<<<<<<< HEAD
#Preview {
    CardView(
        index: 0,
        card: Meet(title: "Praia no sabado", time: "Tarde", description: "Manhã na praia para curtir o sol, o mar e a companhia um do outro.", ideas: ["Praia", "Bronze", "Sol"])
    )
}
=======
//#Preview {
//    CardView(card: Meet(title: "Picnic", description: "Parque", ideas: ["1", "2", "3"]))
//}
>>>>>>> Pickers
