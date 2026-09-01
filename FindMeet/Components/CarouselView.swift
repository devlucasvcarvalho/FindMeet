//
//  CarouselView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct CarouselCardView: View {
    let meets: [Meet]
    @State private var scrollPosition: Int?
    @State private var showConfirmation = false

    var onConfirm: ((Meet) -> Void)? = nil

    private let cardWidth: CGFloat = 250
    private let cardSpacing: CGFloat = -65

    private var selection: Int {
        scrollPosition ?? 0
    }

    var body: some View {
        VStack(spacing: 0) {

            Spacer()

            // Carrossel 3D com sobreposição
            GeometryReader { outerGeo in
                ScrollView(.horizontal) {
                    HStack(spacing: cardSpacing) {
                        ForEach(meets.indices, id: \.self) { index in
                            CardView(
                                card: meets[index],
                                shadowRadius: shadowRadius(for: index)
                            )
                            .id(index)
                            .zIndex(index == selection ? 1 : 0)
                            .visualEffect { content, geo in
                                let distance = distance(index, geo: geo, outerWidth: outerGeo.size.width)
                                return content
                                    .scaleEffect(1 - min(abs(distance), 1) * 0.2)
                                    .opacity(1 - min(abs(distance), 1) * 0.35)
                                    .rotation3DEffect(
                                        .degrees(distance * 25),
                                        axis: (x: 0, y: 1, z: 0),
                                        perspective: 0.6
                                    )
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal, (outerGeo.size.width - cardWidth) / 2)
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollPosition)
                .scrollIndicators(.hidden)
                .mask(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .black, location: 0.06),
                            .init(color: .black, location: 0.94),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
            .frame(height: 420)

            PageIndicator(currentIndex: selection, totalMeets: meets.count)

            Spacer()

            // Botão de confirmar seleção
            Button(action: { showConfirmation = true }) {
                Text("Escolher \"\(meets[selection].title)\"")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.55, green: 0.02, blue: 0.05))
                    )
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .alert("Tem certeza que deseja salvar?", isPresented: $showConfirmation) {
            Button("Cancelar", role: .cancel) { }
            Button("Salvar") {
                onConfirm?(meets[selection])
            }
        } message: {
            Text("\"\(meets[selection].title)\" será salvo.")
        }
    }

    private func distance(_ index: Int, geo: GeometryProxy, outerWidth: CGFloat) -> Double {
        let cardCenterX = geo.frame(in: .global).midX
        let screenCenterX = outerWidth / 2
        let offset = cardCenterX - screenCenterX
        return Double(offset / (cardWidth + cardSpacing))
    }

    private func shadowRadius(for index: Int) -> CGFloat {
        index == selection ? 6.0 : 1.5
    }

    struct PageIndicator: View {
        var currentIndex: Int
        var totalMeets: Int

        var body: some View {
            HStack(spacing: 8) {
                ForEach(0..<totalMeets, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex
                              ? Color(red: 0.55, green: 0.02, blue: 0.05)
                              : Color.gray.opacity(0.4))
                        .frame(width: index == currentIndex ? 10 : 8,
                               height: index == currentIndex ? 10 : 8)
                        .animation(.spring(), value: currentIndex)
                }
            }
            .padding(.top, 12)
        }
    }
}

#Preview {
    CarouselCardView(meets: [
        Meet(title: "Picnic", description: "Parque", ideas: ["Levar champagne", "Manta", "Vinho"]),
        Meet(title: "Cinema", description: "Filme", ideas: ["Levar pipoca", "Filme de comédia", "Sentar atrás"]),
        Meet(title: "Praia", description: "Biquininho", ideas: ["Beach tennis", "Protetor solar", "Água de coco"]),
        Meet(title: "Shopping", description: "compras", ideas: ["Comer depois", "Cinema junto", "Passear"])
    ]) { selected in
        print("Confirmado: \(selected.title)")
    }
}
