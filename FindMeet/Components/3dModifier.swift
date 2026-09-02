////
////  3dModifier.swift
////  FindMeet
////
////  Created by Lucas Vieira de Carvalho on 02/09/26.
////
//
//import SwiftUI
//
//struct Carousel3DEffect: ViewModifier {
//    let currentOffset: CGFloat
//    let cardWidth: CGFloat
//    let cardHeight: CGFloat
//    let spacing: CGFloat
//    let midX: CGFloat
//    let index: Int
//
//    func body(content: Content) -> some View {
//        GeometryReader { geometry in
//            let cardX = geometry.frame(in: .global).midX
//            let distance = cardX - midX
//            
//            let maxDistance = (UIScreen.main.bounds.width / 2) + cardWidth / 2
//            let normalised = max(-1, min(1, distance / maxDistance))
//            
//            let rotationAngle: Double = Double(normalised * -30)
//            let scale = 1.0 - abs(normalised) * 0.15
//            
//            content
//                .scaleEffect(scale)
//                .rotation3DEffect(
//                    Angle(degrees: rotationAngle),
//                    axis: (x: 0, y: 1, z: 0),
//                    perspective: 0.5
//                )
//        }
//        .frame(width: cardWidth, height: cardHeight)
//    }
//}
