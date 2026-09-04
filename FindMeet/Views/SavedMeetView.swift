//
//  SavedMeetView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//


import SwiftUI

struct EncounterCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
}

struct SavedMeetView: View {
    
    @State private var selectedTab: Int = 1
    
    // Controle do Alert Customizado
    @State private var showAlert: Bool = false
    @State private var selectedCardToConclude: EncounterCard? = nil
    
    @State private var cards: [EncounterCard] = [
        EncounterCard(
            title: "Cinema a dois",
            subtitle: "2,4km • Á noite",
            description: "Um cinema pertinho de casa, com filmes em lançamento",
            imageName: "Mascote"
        ),
        EncounterCard(
            title: "Praia de sábado",
            subtitle: "2,4km • De manhã",
            description: "Manhã na praia para curtir o sol, o mar e a companhia um do outro.",
            imageName: "Mascote"
        ),
        EncounterCard(
            title: "Cinema a dois",
            subtitle: "2,4km • Á noite",
            description: "Um cinema pertinho de casa, com filmes em lançamento",
            imageName: "Mascote"
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        
                        Text("Olá, Maria")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.top, 40)
                            .padding(.horizontal, 24)
                        
                        VStack(spacing: 24) {
                            ForEach(cards) { card in
                                NavigationLink(destination: CardDetailView(card: card)) {
                                    SavedCardsView(
                                        title: card.title,
                                        subtitle: card.subtitle,
                                        description: card.description,
                                        imageName: card.imageName,
                                        onConclude: {
                                            selectedCardToConclude = card
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                                showAlert = true
                                            }
                                        }
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 110)
                }
                
                customTabBar
                    .padding(.bottom, 16)
            }
            .overlay {
                if showAlert {
                    CustomAlertView(
                        onConclude: {
                            if let cardToConclude = selectedCardToConclude {
                                cards.removeAll { $0.id == cardToConclude.id }
                            }
                            withAnimation {
                                showAlert = false
                            }
                        },
                        onCancel: {
                            withAnimation {
                                showAlert = false
                            }
                        }
                    )
                }
            }
        }
    }
    
    private var customTabBar: some View {
        HStack(spacing: 0) {
            Button {
                selectedTab = 0
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                    Text("Gerar")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                }
                .foregroundColor(selectedTab == 0 ? Color(red: 140/255, green: 20/255, blue: 20/255) : .black.opacity(0.6))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selectedTab == 0 ? Color.black.opacity(0.06) : Color.clear)
                .clipShape(Capsule())
            }
            
            Button {
                selectedTab = 1
            } label: {
                VStack(spacing: 4) {
                    Image(systemName: "filemenu.and.selection")
                        .font(.system(size: 18))
                    Text("Marcados")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                }
                .foregroundColor(selectedTab == 1 ? Color(red: 140/255, green: 20/255, blue: 20/255) : .black.opacity(0.6))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selectedTab == 1 ? Color.black.opacity(0.06) : Color.clear)
                .clipShape(Capsule())
            }
        }
        .padding(6)
        .frame(width: 250)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.12), radius: 12, x: 0, y: 6)
    }
}

struct CustomAlertView: View {
    let onConclude: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onCancel()
                }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Tem certeza que seja conculir esse Date?")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .lineSpacing(2)
                
                Text("Após finalizada, o date não será mais visível.")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                    .lineSpacing(2)
                    .padding(.bottom, 8)
                
                Button(action: onConclude) {
                    Text("Concluir")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(red: 115/255, green: 0/255, blue: 0/255))
                        .clipShape(Capsule())
                }
                
                Button(action: onCancel) {
                    Text("Cancelar")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.black.opacity(0.18))
                        .clipShape(Capsule())
                }
            }
            .padding(24)
            .frame(maxWidth: 320)
            .background(Color(red: 215/255, green: 215/255, blue: 215/255))
            .cornerRadius(28)
            .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
        }
    }
}

struct CardDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let card: EncounterCard
    
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
                    
                    Button {
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(buttonCircleColor)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 10)
                
                Text(card.title)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cardBackgroundColor)
                    
                    Text(card.description)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.black)
                        .lineSpacing(4)
                        .padding(20)
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(card.imageName)
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
                    
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .offset(x: 5, y: 10)
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SavedMeetView()
}
