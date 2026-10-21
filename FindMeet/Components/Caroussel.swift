import SwiftUI
import Combine

// MARK: - Generic Infinite Carousel
protocol CarouselItem: Equatable {
    var imageName: String { get }
    var title: String { get }
}

struct InfiniteCarouselView<T: CarouselItem>: View {
    
    // MARK: - Layout (calculado a partir do espaço disponível)
    
    private struct Metrics {
        let cardWidth: CGFloat
        let cardHeight: CGFloat
        let spacing: CGFloat = 0
        
        var step: CGFloat { cardWidth + spacing }
        /// carta + título embaixo
        var contentHeight: CGFloat { cardHeight + 60 }
        
        init(available: CGSize) {
            // espaço reservado: título da carta (60) + pontinhos (8) + espaçamento (20) + folga
            let reserved: CGFloat = 60 + 8 + 20 + 8
            let height = min(350, max(140, available.height - reserved))
            cardHeight = height
            cardWidth = height * (178.0 / 350.0)
        }
    }
    
    let items: [T]
    
    // MARK: - Selection
    
    @Binding var selected: T
    
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
        GeometryReader { outer in
            let m = Metrics(available: outer.size)
            
            VStack(spacing: 20) {
                
                GeometryReader { geometry in
                    
                    let midX = geometry.size.width / 2
                    
                    HStack(spacing: m.spacing) {
                        
                        ForEach(items.indices, id: \.self) { index in
                            
                            let item = items[index]
                            
                            VStack(spacing: 12) {
                                
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: m.cardWidth,
                                        height: m.cardHeight
                                    )
                                    .accessibilityHidden(true)
                                
                                Spacer()
                                
                                Text(item.title)
                                    .font(.custom("Fredoka-regular", size: 20))
                                    .foregroundStyle(.secondary)
                                    .accessibilityLabel("\(item.title)")
                            }
                            .frame(width: m.cardWidth, height: m.contentHeight)
                            .id(index)
                            .modifier(
                                Carousel3DEffect(
                                    currentOffset: offset,
                                    cardWidth: m.cardWidth,
                                    cardHeight: m.cardHeight,
                                    spacing: m.spacing,
                                    midX: midX,
                                    index: index
                                )
                            )
                            .onTapGesture {
                                selectItem(index: index, geometry: geometry, m: m)
                            }
                        }
                    }
                    .offset(x: isSnapping ? snapOffset : offset)
                    .onReceive(timer) { _ in
                        if isAutoScrollingEnabled &&
                            !isManuallyDragging &&
                            !isSnapping {
                            
                            withAnimation(.linear(duration: 0.03)) {
                                offset -= CGFloat(speedMultiplier)
                            }
                            
                            let fullSetWidth = m.step * CGFloat(items.count)
                            
                            if -offset >= fullSetWidth {
                                offset += fullSetWidth
                            }
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isSnapping = false
                                lastDragOffset = value.translation.width
                                isManuallyDragging = true
                                offset = dragStartOffset + value.translation.width
                            }
                            .onEnded { _ in
                                isManuallyDragging = false
                                lastDragOffset = 0
                                snapToNearestItem(geometry: geometry, m: m)
                            }
                    )
                    .onAppear {
                        dragStartOffset = offset
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            snapToNearestItem(geometry: geometry, m: m)
                        }
                    }
                    // se a janela/orientação mudar, recentraliza a carta atual
                    .onChange(of: m.cardWidth) {
                        let target = midX - (CGFloat(currentIndex) * m.step + m.cardWidth / 2)
                        offset = target
                        snapOffset = target
                        dragStartOffset = target
                    }
                }
                .frame(height: m.contentHeight)
                .clipped()
                
                HStack {
                    ForEach(0..<items.count, id: \.self) { i in
                        Circle()
                            .fill(i == currentIndex
                                  ? Color(red: 0.55, green: 0.02, blue: 0.05)
                                  : Color.gray.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .frame(width: outer.size.width, height: outer.size.height)
        }
    }
    
    // MARK: - Snap To Nearest Item
    
    private func snapToNearestItem(geometry: GeometryProxy, m: Metrics) {
        
        let screenCenter = geometry.size.width / 2
        
        var minDistance: CGFloat = .infinity
        var targetOffset: CGFloat = offset
        var targetIndex: Int = currentIndex
        
        for i in items.indices {
            
            let cardPosition = CGFloat(i) * m.step + offset + m.cardWidth / 2
            let distance = abs(cardPosition - screenCenter)
            
            if distance < minDistance {
                minDistance = distance
                targetOffset = screenCenter - (CGFloat(i) * m.step + m.cardWidth / 2)
                targetIndex = i
            }
        }
        
        currentIndex = targetIndex
        selected = items[targetIndex]
        
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
    
    // MARK: - Select Item
    
    private func selectItem(index: Int, geometry: GeometryProxy, m: Metrics) {
        
        let screenCenter = geometry.size.width / 2
        let targetOffset = screenCenter - (CGFloat(index) * m.step + m.cardWidth / 2)
        
        currentIndex = index
        selected = items[index]
        
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

// MARK: - Previews

#Preview {
    @Previewable @State var style: MeetStyleEnum = .gastronomic
    InfiniteCarouselView(items: MeetStyleEnum.allCases, selected: $style)
}

#Preview {
    @Previewable @State var time: MeetTimeEnum = .evening
    InfiniteCarouselView(items: MeetTimeEnum.allCases, selected: $time)
}
