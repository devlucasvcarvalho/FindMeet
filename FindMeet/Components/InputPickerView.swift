import SwiftUI
import Combine

// MARK: - Main View

struct InfiniteCarouselInputView: View {
    
    // MARK: - Configuration
    
    private let spacing: CGFloat = 0
    private let cardWidth: CGFloat = 178
    private let cardHeight: CGFloat = 350
    
    private let styles = MeetStyleEnum.allCases
    
    // MARK: - Selection
    
    @Binding var selectedStyle: MeetStyleEnum
//    @Binding var selectedTime: MeetTimeEnum
    
    // MARK: - Carousel State
    
    @State private var offset: CGFloat = 0
    @State private var currentIndex: Int = 0
    
    @State private var isAutoScrollingEnabled = false
    @State private var speedMultiplier: Double = 1.0
    
    @State private var isManuallyDragging = false
    @State private var dragStartOffset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    
    @State private var isSnapping = false
    @State private var snapOffset: CGFloat = 0
    
    // MARK: - Timer
    
    private let timer = Timer.publish(
        every: 0.03,
        on: .main,
        in: .common
    ).autoconnect()
    
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            GeometryReader { geometry in
                
                let totalWidth = cardWidth + spacing
                let midX = geometry.size.width / 2
                
                HStack(spacing: spacing) {
                    
                    ForEach(styles.indices, id: \.self) { index in
                        
                        let style = styles[index]
                        
                        VStack(spacing: 12) {
                            
                            // MARK: Image
                            
                            Image(style.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: cardWidth,
                                    height: cardHeight
                                )
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 20
                                    )
                                )
                                .overlay {
                                    RoundedRectangle(
                                        cornerRadius: 20
                                    )
                                    .stroke(
                                        Color.white.opacity(0.2),
                                        lineWidth: 1
                                    )
                                }
                            
                            // MARK: Title
                            
                            Text(style.styles)
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                        .frame(
                            width: cardWidth,
                            height: cardHeight + 40
                        )
                        .id(index)
                        .modifier(
                            Carousel3DEffect(
                                currentOffset: offset,
                                cardWidth: cardWidth,
                                cardHeight: cardHeight,
                                spacing: spacing,
                                midX: midX,
                                index: index
                            )
                        )
                        .onTapGesture {
                            selectStyle(
                                index: index,
                                geometry: geometry
                            )
                        }
                    }
                }
                
                // MARK: Offset
                
                .offset(
                    x: isSnapping
                    ? snapOffset
                    : offset
                )
                
                // MARK: Auto Scroll
                
                .onReceive(timer) { _ in
                    
                    if isAutoScrollingEnabled &&
                        !isManuallyDragging &&
                        !isSnapping {
                        
                        withAnimation(
                            .linear(duration: 0.03)
                        ) {
                            offset -= CGFloat(
                                speedMultiplier
                            )
                        }
                        
                        let fullSetWidth =
                            totalWidth *
                            CGFloat(styles.count)
                        
                        if -offset >= fullSetWidth {
                            offset += fullSetWidth
                        }
                    }
                }
                
                // MARK: Drag Gesture
                
                .gesture(
                    DragGesture()
                    
                        .onChanged { value in
                            
                            isSnapping = false
                            
                            let dragChange =
                                value.translation.width -
                                lastDragOffset
                            
//                            dragVelocity =
//                                dragChange / 0.016
                            
                            lastDragOffset =
                                value.translation.width
                            
                            isManuallyDragging = true
                            
                            offset =
                                dragStartOffset +
                                value.translation.width
                        }
                    
                        .onEnded { value in
                            
                            isManuallyDragging = false
                            
                            lastDragOffset = 0
                            
                            snapToNearestCard(
                                geometry: geometry
                            )
                        }
                )
                
                // MARK: Initial Position
                
                .onAppear {
                    
                    dragStartOffset = offset
                    
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.1
                    ) {
                        snapToNearestCard(
                            geometry: geometry
                        )
                    }
                }
            }
            .frame(height: cardHeight + 80)
            .clipped()
            
            Spacer()
        }
    }
    
    
    // MARK: - Snap To Nearest Card
    
    private func snapToNearestCard(
        geometry: GeometryProxy
    ) {
        
        let totalWidth = cardWidth + spacing
        let screenCenter = geometry.size.width / 2
        
        var minDistance: CGFloat = .infinity
        var targetOffset: CGFloat = offset
        var targetIndex: Int = currentIndex
        
        for i in styles.indices {
            
            let cardPosition =
                CGFloat(i) * totalWidth +
                offset +
                cardWidth / 2
            
            let distance =
                abs(cardPosition - screenCenter)
            
            if distance < minDistance {
                
                minDistance = distance
                
                targetOffset =
                    screenCenter -
                    (
                        CGFloat(i) * totalWidth +
                        cardWidth / 2
                    )
                
                targetIndex = i
            }
        }
        
        // Atualiza o índice selecionado
        currentIndex = targetIndex
        
        // Atualiza o enum selecionado
        selectedStyle = styles[targetIndex]
        
        // Anima o movimento
        withAnimation(
            .spring(
                response: 0.3,
                dampingFraction: 0.7
            )
        ) {
            isSnapping = true
            snapOffset = targetOffset
        }
        
        // Finaliza o snap
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.3
        ) {
            
            offset = targetOffset
            
            isSnapping = false
            
            dragStartOffset = offset
        }
    }
    
    
    // MARK: - Select Style
    
    private func selectStyle(
        index: Int,
        geometry: GeometryProxy
    ) {
        
        let totalWidth = cardWidth + spacing
        let screenCenter = geometry.size.width / 2
        
        let targetOffset =
            screenCenter -
            (
                CGFloat(index) * totalWidth +
                cardWidth / 2
            )
        
        currentIndex = index
        selectedStyle = styles[index]
        
        withAnimation(
            .spring(
                response: 0.3,
                dampingFraction: 0.7
            )
        ) {
            isSnapping = true
            snapOffset = targetOffset
        }
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.3
        ) {
            
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
            
            let cardX =
                geometry.frame(
                    in: .global
                ).midX
            
            let distance =
                cardX - midX
            
            let maxDistance =
                (UIScreen.main.bounds.width / 2) +
                cardWidth / 2
            
            let normalised =
                max(
                    -1,
                    min(
                        1,
                        distance / maxDistance
                    )
                )
            
            // Rotação 3D
            let rotationAngle: Double =
                Double(normalised * -30)
            
            // Escala
            let scale =
                1.0 -
                abs(normalised) * 0.15
            
            content
                .scaleEffect(scale)
                .rotation3DEffect(
                    Angle(
                        degrees: rotationAngle
                    ),
                    axis: (
                        x: 0,
                        y: 1,
                        z: 0
                    ),
                    perspective: 0.5
                )
        }
        .frame(
            width: cardWidth,
            height: cardHeight + 40
        )
    }
}


// MARK: - Preview

#Preview {
    
    InfiniteCarouselInputView(
        selectedStyle: .constant(
            MeetStyleEnum.gastronomic
        )
    )
}
