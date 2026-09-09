//
//  SwiftUIView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

import SwiftUI
import Combine

// MARK: - Generic Infinite Carousel
protocol CarouselItem: Equatable {
    var imageName: String { get }
    var title: String { get }
}

struct InfiniteCarouselView<T: CarouselItem>: View {

    // MARK: - Configuration

    private let spacing: CGFloat = 0
    private let cardWidth: CGFloat = 189
    private let cardHeight: CGFloat = 350

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

        VStack(spacing: 20) {

            Spacer()

            GeometryReader { geometry in

                let totalWidth = cardWidth + spacing
                let midX = geometry.size.width / 2

                HStack(spacing: spacing) {

                    ForEach(items.indices, id: \.self) { index in

                        let item = items[index]

                        VStack(spacing: 12) {

                            Image(item.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: cardWidth,
                                    height: cardHeight
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            Color.white.opacity(0.2),
                                            lineWidth: 1
                                        )
                                }

                            Text(item.title)
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
                            selectItem(index: index, geometry: geometry)
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

                        let fullSetWidth = totalWidth * CGFloat(items.count)

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
                            lastDragOffset = value.translation.width
                            isManuallyDragging = true

                            offset = dragStartOffset + value.translation.width
                        }
                        .onEnded { value in
                            isManuallyDragging = false
                            lastDragOffset = 0
                            snapToNearestItem(geometry: geometry)
                        }
                )
                .onAppear {
                    dragStartOffset = offset

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        snapToNearestItem(geometry: geometry)
                    }
                }
            }
            .frame(height: cardHeight + 80)
            .clipped()

            Spacer()
        }
    }

    // MARK: - Snap To Nearest Item

    private func snapToNearestItem(geometry: GeometryProxy) {

        let totalWidth = cardWidth + spacing
        let screenCenter = geometry.size.width / 2

        var minDistance: CGFloat = .infinity
        var targetOffset: CGFloat = offset
        var targetIndex: Int = currentIndex

        for i in items.indices {

            let cardPosition = CGFloat(i) * totalWidth + offset + cardWidth / 2
            let distance = abs(cardPosition - screenCenter)

            if distance < minDistance {
                minDistance = distance
                targetOffset = screenCenter - (CGFloat(i) * totalWidth + cardWidth / 2)
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

    private func selectItem(index: Int, geometry: GeometryProxy) {

        let totalWidth = cardWidth + spacing
        let screenCenter = geometry.size.width / 2

        let targetOffset = screenCenter - (CGFloat(index) * totalWidth + cardWidth / 2)

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

//#Preview {
//    @Previewable @State var style: MeetStyleEnum = .gastronomic
//    InfiniteCarouselView(items: MeetStyleEnum.allCases, selected: $style)
//}
//
//#Preview {
//    @Previewable @State var time: MeetTimeEnum = .evening
//    InfiniteCarouselView(items: MeetTimeEnum.allCases, selected: $time)
//}
