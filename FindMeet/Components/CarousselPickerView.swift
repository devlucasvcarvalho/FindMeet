//
//  CarouselPickerView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 02/09/26.
//


import SwiftUI
import Combine



// MARK: - Main View
struct InfiniteCarousel: View {
    private let cardCount = 5
    private let spacing: CGFloat = 0
    private let cardWidth: CGFloat = 250
    private let cardHeight: CGFloat = 350
   
    

    @State private var offset: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var isAutoScrollingEnabled = false
    @State private var speedMultiplier: Double = 1.0
    
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    @State private var isManuallyDragging = false
    @State private var dragStartOffset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    @State private var dragVelocity: CGFloat = 0
    
    @State private var isSnapping = false
    @State private var snapOffset: CGFloat = 0
    
    let meets: [Meet]
    @State private var scrollPosition: Int?
    private var selection: Int {
        scrollPosition ?? 0
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            GeometryReader { geometry in
                let totalWidth = cardWidth + spacing
                let midX = geometry.size.width / 2

                HStack(spacing: spacing) {
                    ForEach(meets.indices, id: \.self) { index in
                        CardView(
                            card: meets[index]
                        )
                        .id(index)
                            .frame(width: cardWidth, height: cardHeight)
                            .modifier(Carousel3DEffect(
                                currentOffset: offset,
                                cardWidth: cardWidth,
                                cardHeight: cardHeight,
                                spacing: spacing,
                                midX: midX,
                                index: index
                            ))
                    }
                }
//                .scaleEffect(x: cards.isPressed ? 0.96 : 1, y: cards.isPressed ? 0.96 : 1) // ADD THIS TO ANIMATE THE TOUCH!!!!
                .offset(x: isSnapping ? snapOffset : offset)
                .onReceive(timer) { _ in
                    if isAutoScrollingEnabled && !isManuallyDragging && !isSnapping {
                        withAnimation(.linear(duration: 0.03)) {
                            offset -= CGFloat(speedMultiplier)
                        }
                        let fullSetWidth = totalWidth * CGFloat(cardCount)
                        if -offset >= fullSetWidth {
                            offset += fullSetWidth
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isSnapping = false
                            
                            let dragChange = value.translation.width - lastDragOffset
                            dragVelocity = dragChange / 0.016
                            lastDragOffset = value.translation.width
                            
                            if !isAutoScrollingEnabled {
                                offset = dragStartOffset + value.translation.width
                            } else {
                                isManuallyDragging = true
                                offset = dragStartOffset + value.translation.width
                            }
                        }
                        .onEnded { value in
                            if !isAutoScrollingEnabled {
                                snapToNearestCard(geometry: geometry)
                            } else {
                                isManuallyDragging = false
                                dragStartOffset = offset
                            }
                        }
                )
                .onAppear {
                    dragStartOffset = offset
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        snapToNearestCard(geometry: geometry)
                    }
                }
            }
            .frame(height: cardHeight + 40)
            .clipped()
            
            
            
            Spacer()
        }
    }
    
    
    private func snapToNearestCard(geometry: GeometryProxy) {
        let totalWidth = cardWidth + spacing
        let screenCenter = geometry.size.width / 2
        
        var minDistance: CGFloat = .infinity
        var targetOffset: CGFloat = offset
        var targetIndex: Int = 0
        
        let startIndex = max(0, currentIndex - 2)
            let endIndex = min(meets.count - 1, currentIndex + 2)
        
        for i in meets.indices {
            let cardPosition = CGFloat(i) * totalWidth + offset + cardWidth / 2
            let distance = abs(cardPosition - screenCenter)
            
            if distance < minDistance {
                minDistance = distance
                targetOffset = screenCenter - (CGFloat(i) * totalWidth + cardWidth / 2)
                targetIndex = i
            }
        }
        
        currentIndex = targetIndex
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isSnapping = true
            snapOffset = targetOffset
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            offset = targetOffset
            isSnapping = false
            dragStartOffset = offset
        }
    }
}

// MARK: - 3D Effect Modifier
struct Carousel3DEffect: ViewModifier {
    let currentOffset: CGFloat
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    let spacing: CGFloat
    let midX: CGFloat
    let index: Int

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let cardX = geometry.frame(in: .global).midX
            let distance = cardX - midX

            let maxDistance = (UIScreen.main.bounds.width / 2) + cardWidth / 2
            let normalised = max(-1, min(1, distance / maxDistance))

            let rotationAngle: Double = Double(normalised * -30)
            let scale = 1.0 - abs(normalised) * 0.15

            content
                .scaleEffect(scale)
                .rotation3DEffect(
                    Angle(degrees: rotationAngle),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
        }
        .frame(width: cardWidth, height: cardHeight)
    }
}







// MARK: - Preview
#Preview {
    InfiniteCarousel(meets: [
        Meet(title: "Picnic", description: "Parque", ideas: ["Levar champagne", "Manta", "Vinho"]),
        Meet(title: "Cinema", description: "Filme", ideas: ["Levar pipoca", "Filme de comédia", "Sentar atrás"]),
        Meet(title: "Praia", description: "Biquininho", ideas: ["Beach tennis", "Protetor solar", "Água de coco"])
    ])
}
