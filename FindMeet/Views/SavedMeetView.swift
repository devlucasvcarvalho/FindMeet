//
//  SavedMeetView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//


//
//  SavedMeetView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI
import SwiftData

struct SavedMeetView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var savedData: [SavedData]

    @State private var selectedTab: Int = 1
    
    // Controle do Alert Customizado
    @State private var showAlert: Bool = false
    @State private var selectedCardToConclude: SavedData? = nil
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        
                        Text("Ideias salvas")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .padding(.top, 40)
                            .padding(.horizontal, 24)
                        
                        VStack(spacing: 24) {
                            ForEach(savedData) { card in
                                NavigationLink(destination: CardDetailView(card: card)) {
                                    SavedCardsView(
                                        title: card.title,
                                        subtitle: card.time,
                                        description: card.descriptions,
                                        imageName: "Mascote",
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
            }
            .appPopup(isPresented: $showAlert) {
                            PopUpview(
                                title: "Tem certeza que deseja concluir esse Date?",
                                message: "Após finalizado, o date não será mais visível.",
                                secondaryButton: .init(label: "Cancelar", style: .secondary, action: {
                                    withAnimation { showAlert = false }
                                }),
                                primaryButton: .init(label: "Concluir", style: .primary, action: {
                                    // Ação de deletar e salvar
                                    if let cardToConclude = selectedCardToConclude {
                                        modelContext.delete(cardToConclude)
                                        do {
                                            try modelContext.save()
                                        } catch {
                                            print("Erro ao deletar: \(error)")
                                        }
                                    }
                                    withAnimation { showAlert = false }
                                }),
                                onTapBackground: {
                                    withAnimation { showAlert = false }
                                }
                            )
                        }
        }
    }
}
//MARK: Pop up
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


#Preview {
    SavedMeetView()
        .modelContainer(for: SavedData.self, inMemory: true)
}
