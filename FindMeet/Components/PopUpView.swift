//
//  PopUpView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 09/09/26.
//

import SwiftUI

// MARK: - Popup genérico

struct PopUpview: View {
    
    struct PopupButton {
        enum Style {
            case primary       // vermelho sólido — ação principal/destrutiva
            case secondary     // cinza claro — cancelar/dispensar
        }
        
        let label: String
        var style: Style = .secondary
        let action: () -> Void
    }
    
    var icon: String? = nil
    let title: String
    var message: String? = nil
    let secondaryButton: PopupButton   // NOVO: campo fixo
    let primaryButton: PopupButton
    
    // Se definido, tocar fora do card chama essa ação (geralmente igual ao botão "cancelar")
    var onTapBackground: (() -> Void)? = nil
    
    private let primaryColor = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { onTapBackground?() }
            
            VStack(spacing: 16) {
                
                Text(title)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                
                if let message {
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                HStack(spacing: 12) {
                    popupButton(secondaryButton)
                    popupButton(primaryButton)
                }
            }
            .padding(24)
            .background {
                if #available(iOS 26.0, *) {
                    Color.clear
                        .glassEffect(.regular, in: .rect(cornerRadius: 20))
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.regularMaterial)
                }
            }
            .padding(.horizontal, 40)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        }
        .accessibilityAddTraits(.isModal)
    }
        
    
    @ViewBuilder
    private func popupButton(_ button: PopupButton) -> some View {
        Button {
            button.action()
        } label: {
            Text(button.label)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .foregroundStyle(button.style == .primary ? .white : .primary)
        .background(button.style == .primary ? primaryColor : Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Modifier de conveniência
// Uso: .appPopup(isPresented: $showPopup) { AppPopup(...) }

extension View {
    func appPopup<PopupContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder popup: @escaping () -> PopupContent
    ) -> some View {
        self.overlay {
            if isPresented.wrappedValue {
                popup()
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented.wrappedValue)
    }
}



//#Preview("Confirmação (2 botões)") {
//    PopUpview(
//        icon: "exclamationmark.triangle.fill",
//        title: "Voltar para o início?",
//        message: "Você vai sair dessa etapa e voltar para a tela inicial.",
//        secondaryButton: .init(label: "Cancelar", style: .secondary, action: {}),
//        primaryButton: .init(label: "Sair", style: .primary, action: {})
//    )
//}
//
//#Preview("Aviso simples (1 botão)") {
//    PopUpview(
//        icon: "exclamationmark.circle.fill",
//        title: "Preencha todos os campos",
//        message: "Selecione uma opção antes de continuar.",
//        secondaryButton: .init(label: "Cancelar", style: .secondary, action: {}),
//        primaryButton: .init(label: "Sair", style: .primary, action: {})
//    )
//}
//
//#Preview("Sem ícone, sem mensagem") {
//    PopUpview(
//        title: "Encontro salvo!",
//        secondaryButton: .init(label: "Cancelar", style: .secondary, action: {}),
//        primaryButton: .init(label: "Sair", style: .primary, action: {})
//    )
//}
