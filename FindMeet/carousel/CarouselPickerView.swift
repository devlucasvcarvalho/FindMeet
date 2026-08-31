//
//  CarouselPickerView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 30/08/26.
//

import SwiftUI
import Foundation



struct  Items : Identifiable {
    let id: Int
    let title: String
    let color: Color
 }

struct InteractiveCarousel: View {
    @Binding var items: [Items] // Binding to an array of Item objects
    @State private var snappedItem = 0.0 // Current stable position after user interaction
    @State private var draggingItem = 0.0 // Dynamic position during drag
    
    // Normalize index calculation to ensure it's always valid
    var normalizedIndex: Int {
        let baseIndex = Int(round(draggingItem)) // Round the dragging item to get the base index
        let itemsCount = items.count // Total number of items in the carousel
        return (baseIndex % itemsCount + itemsCount) % itemsCount // Ensure index wraps correctly
    }
    
    var body: some View {
        VStack {
            ZStack {
                // Create a ZStack to layer items on top of each other
                ForEach(items) { item in
                    ZStack {
                        // Each item is represented as a rounded rectangle with text
                        RoundedRectangle(cornerRadius: 18)
                            .fill(item.color) // Fill with item's color
                        Text(item.title) // Display item's title
                            .padding()
                    }
                    .frame(width: 250, height: 350) // Set frame size for each item
                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.15) // Scale effect based on distance from center
                    .offset(x: myXOffset(item.id), y: 0) // Offset for curved layout positioning
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1) // Adjust z-index for layering effect
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Update draggingItem based on drag gesture translation
                        draggingItem = snappedItem - value.translation.width / 100
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            // Calculate predicted end position after drag ends
                            let predictedEnd = snappedItem - value.predictedEndTranslation.width / 100
                            let nextIndex = Int(round(predictedEnd)) // Determine next index based on prediction
                            let itemsCount = items.count

                            // Improved wrapping logic to ensure valid index after drag ends
                            snappedItem = Double((nextIndex % itemsCount + itemsCount) % itemsCount)
                            draggingItem = snappedItem // Update draggingItem to match snappedItem for consistency
                        }
                    }
            )
            
            // Page indicator showing the current selected item index
            PageIndicator(currentIndex: normalizedIndex, totalItems: items.count)
        }
    }

    // Calculate distance from the currently active item for scaling and positioning effects
    func distance(_ item: Int) -> Double {
        let offset = draggingItem - Double(item)
        return (offset + Double(items.count)/2).truncatingRemainder(dividingBy: Double(items.count)) - Double(items.count)/2
    }

    // Calculate x-offset for curved layout using sine function for smooth transition effect
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 1.4 / Double(items.count) * distance(item)
        return -sin(angle) * 100 // Return negative sine value for proper positioning in carousel arc
    }
}

struct PageIndicator: View {
    var currentIndex: Int // Current selected index of the carousel item
    var totalItems: Int   // Total number of items in the carousel
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalItems, id: \.self) { index in
                Circle() // Create a circular indicator for each item
                    .fill(index == currentIndex ? Color.blue : Color.gray.opacity(0.5)) // Change color based on selection state
                    .frame(width: index == currentIndex ? 12 : 8, height: index == currentIndex ? 12 : 8) // Adjust size based on selection state
                    .animation(.spring(), value: currentIndex) // Smooth animation when changing selection state
            }
        }
        .padding(.top, 15) // Add padding above the indicators for spacing from carousel
    }
}

