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
        VStack(spacing: 16) {
            Spacer(minLength: 0)

            Text("Find\nMeet")
                .font(.custom("Fredoka-SemiBold", size: 52))
                .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)   // nunca trunca
                .rotationEffect(.degrees(-8))
                .offset(x: -70)
                .zIndex(1)

            Image("feliz")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 340, maxHeight: 400)            // encolhe se faltar espaço
                .scaleEffect(isPulsing ? 1.06 : 1.0)
                .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: isPulsing)

            Text("Encontros que combinam com vocês.")
                .font(.custom("Fredoka-Medium", size: 24))
                .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .padding()
        .appBackground()
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
