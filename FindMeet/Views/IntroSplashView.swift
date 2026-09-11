//
//  IntroView'.swift
//  FindMeet
//
//  Created by Cintia Raquel on 11/09/26.
//

import SwiftUI

struct IntroSplashView: View {
    let onFinished: () -> Void

    @State private var isPulsing = false

    var body: some View {
        VStack(spacing: 0) {
            Text("Find\nMeet")
                .font(.system(size: 52, weight: .black, design: .rounded))
                .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                .multilineTextAlignment(.center)
                .rotationEffect(.degrees(-8))
                .offset(x: -70, y: 110)
                .zIndex(1)

            Spacer()

            Image("feliz")
                .resizable()
                .scaledToFit()
                .frame(width: 320, height: 390)
                .scaleEffect(isPulsing ? 1.06 : 1.0)
                .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: isPulsing)
                .offset(y: -35)

            Spacer()

            Text("Encontros que combinam\ncom vocês.")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                .multilineTextAlignment(.center)
                .offset(y: -90)
        }
        .padding()
        .appBackground()
        .ignoresSafeArea(edges: .all)
        .toolbar(.hidden, for: .tabBar)
        .task {
            isPulsing = true
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            guard !Task.isCancelled else { return }

            AppSessionState.hasShownLaunchIntro = true
            withAnimation(.spring(response: 0.45, dampingFraction: 0.7)) {
                onFinished()
            }
        }
    }
}
#Preview {
    IntroSplashView(onFinished: {
        print("Splash terminou")
    })
}
