//
//  AppBackgroundView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 10/09/26.
//

import SwiftUI

struct AppBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Image(colorScheme == .dark ? "BGpinkdark" : "BGpinklight")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

extension View {
    func appBackground() -> some View {
        self.background(AppBackgroundView())
    }
}
