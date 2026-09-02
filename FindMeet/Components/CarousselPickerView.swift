
import SwiftUI
import Combine


// MARK: -  Data Model para Teste
// TODO: EXCLUIR!!
struct CardData: Identifiable {
    let id = UUID()
    let name: String
    let rating: Double
    let location: String
    let experience: String
    let title: String
    let salary: Int
    let profileImage: String // Image name
    let backgroundColor: Color
    let isPressed: Bool
}

// MARK: - Main View
struct InfiniteCarousel: View {
    private let cardCount = 5
    private let spacing: CGFloat = 0
    private let cardWidth: CGFloat = 280
    private let cardHeight: CGFloat = 340
    
    // Card data array
    // TODO: EXCLUIR!!
    private let cards: [CardData] = [
        CardData(
            name: "Muhammad Taha",
            rating: 4.8,
            location: "New York",
            experience: "3+ Years",
            title: "Hardware Engineer",
            salary: 2400,
            profileImage: "ic_Profile",
            backgroundColor: Color.primaryGreen,
            isPressed: false
        ),
        CardData(
            name: "Sarah Johnson",
            rating: 4.9,
            location: "San Francisco",
            experience: "5+ Years",
            title: "Software Architect",
            salary: 3200,
            profileImage: "ic_Profile2",
            backgroundColor: Color.primaryBlue,
            isPressed: false

        ),
        CardData(
            name: "Alex Chen",
            rating: 4.7,
            location: "London",
            experience: "2+ Years",
            title: "UX Designer",
            salary: 2100,
            profileImage: "ic_Profile3",
            backgroundColor: Color.primaryOrange,
            isPressed: false
        ),
        CardData(
            name: "Maria Garcia",
            rating: 5.0,
            location: "Madrid",
            experience: "4+ Years",
            title: "Product Manager",
            salary: 2800,
            profileImage: "ic_Profile4",
            backgroundColor: Color.primaryPurple,
            isPressed: false
        ),
        CardData(
            name: "James Wilson",
            rating: 4.6,
            location: "Sydney",
            experience: "1+ Years",
            title: "Junior Developer",
            salary: 1800,
            profileImage: "ic_Profile5",
            backgroundColor: Color.primaryMint,
            isPressed: false
        )
    ]

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

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            GeometryReader { geometry in
                let totalWidth = cardWidth + spacing
                let midX = geometry.size.width / 2

                HStack(spacing: spacing) {
                    ForEach(0..<100, id: \.self) { i in
                        Card(data: cards[i % cards.count])
                            .frame(width: cardWidth, height: cardHeight)
                            .modifier(Carousel3DEffect(
                                currentOffset: offset,
                                cardWidth: cardWidth,
                                cardHeight: cardHeight,
                                spacing: spacing,
                                midX: midX,
                                index: i
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
            
            VStack(spacing: 16) {
                Button(action: {
                    isAutoScrollingEnabled.toggle()
                    isManuallyDragging = false
                    if !isAutoScrollingEnabled {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: isAutoScrollingEnabled ? "pause.circle.fill" : "play.circle.fill")
                            .font(.title)
                        Text(isAutoScrollingEnabled ? "Pause Auto-Scroll" : "Start Auto-Scroll")
                            .font(.headline)
                    }
                    .foregroundColor(isAutoScrollingEnabled ? .primaryOrange : .primaryGreen)
                }
                
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "tortoise")
                            .foregroundColor(.gray)
                            .font(.system(size: 24))
                        Slider(
                            value: $speedMultiplier,
                            in: 0.5...3.0,
                            step: 0.1
                        )
                        .tint(Color.primaryGreen)
                        .disabled(!isAutoScrollingEnabled)
                        .opacity(isAutoScrollingEnabled ? 1.0 : 0.5)
                        
                        
                        Image(systemName: "hare")
                            .foregroundColor(.gray)
                            .font(.system(size: 24))
                    }
                    
                    Text("Speed: \(String(format: "%.1f", speedMultiplier))x")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 40)
                
                // Page indicators with dynamic data
                HStack {
                    ForEach(0..<cards.count, id: \.self) { i in
                        Circle()
                            .fill(currentIndex % cards.count == i ? Color.primaryGreen : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .padding(.bottom, 20)
            
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
        let endIndex = min(99, currentIndex + 2)
        
        for i in startIndex...endIndex {
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

// MARK: - Card View
struct Card: View {
    let data: CardData

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Profile Image
                Image(data.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 42, height: 42)
                    .clipShape(.circle)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 44, height: 44)
                    )
                
                Spacer()
                
                // Like Button
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 42, height: 42)
                    .overlay {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white.opacity(0.8))
                    }
                
                // Comment Button
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 42, height: 42)
                    .overlay {
                        Image(systemName: "message.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white.opacity(0.8))
                    }
            }
            
            Text(data.name)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(0.9)
            
            HStack {
                // Rating
                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(String(format: "%.1f", data.rating))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.2))
                .cornerRadius(30)
                
                // Location
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.white)
                    
                    Text(data.location)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.2))
                .cornerRadius(30)
            }
            
            // Experience
            HStack(spacing: 6) {
                Image(systemName: "graduationcap.fill")
                    .foregroundColor(.white)
                
                Text(data.experience)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.black.opacity(0.2))
            .cornerRadius(30)
            
            Spacer()
            
            Text(data.title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(0.9)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Senior")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 0) {
                        Text("$\(data.salary)")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text(" / month")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.5))
                        
                        Spacer()
                    }
                }
                
//                Text("More")
//                    .font(.system(size: 24, weight: .semibold, design: .rounded))
//                    .foregroundStyle(Color.white)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 12)
//                    .background(.black)
//                    .cornerRadius(100)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 100)
//                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
//                    )
            }
        }
        .padding(16)
        .background(data.backgroundColor)
        .cornerRadius(30)
        .shadow(color: data.backgroundColor.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Color Extensions
extension Color {
    static let primaryGreen = Color(red: 76/255, green: 175/255, blue: 80/255)
    static let primaryBlue = Color(red: 33/255, green: 150/255, blue: 243/255)
    static let primaryOrange = Color(red: 255/255, green: 152/255, blue: 0/255)
    static let primaryPurple = Color(red: 156/255, green: 39/255, blue: 176/255)
    static let primaryMint = Color(red: 0/255, green: 150/255, blue: 136/255)
}

// MARK: - Preview
#Preview {
    InfiniteCarousel()
}
