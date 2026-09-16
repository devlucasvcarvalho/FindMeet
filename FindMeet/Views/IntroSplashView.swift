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
        VStack(/*spacing: 0*/) {
            Spacer().frame(height: 40)

            Text("Find\nMeet")
                .font(.custom("Fredoka-SemiBold", size: 52))
                .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                .multilineTextAlignment(.center)
                .rotationEffect(.degrees(-8))
                .offset(x: -70, y: 30)
                .zIndex(1)
            

            Spacer()

            Image("feliz")
                .resizable()
                .scaledToFit()
                .frame(width: 340, height: 400)
                .scaleEffect(isPulsing ? 1.06 : 1.0)
                .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: isPulsing)
                .offset(y: -80)

            Spacer().frame(height: 24)

            Text("Encontros que combinam\ncom vocês.")
                .font(.custom("Fredoka-Medium", size: 24))
                .foregroundColor(Color(red: 144/255, green: 3/255, blue: 3/255))
                .multilineTextAlignment(.center)
                .offset(y: -90)
            
            Spacer()
        }
        .padding()
        .appBackground()
        .ignoresSafeArea(edges: .all)
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
