//
//  FindMeetApp.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 26/08/26.
//

import SwiftUI
import SwiftData

@main
struct FindMeetApp: App {

    init() {
        configureNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SavedData.self)
    }
}

private func configureNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    
    if let customFont = UIFont(name: "Fredoka-SemiBold", size: 17) {
        appearance.titleTextAttributes = [.font: customFont]
    } else {
        print("⚠️ Fonte 'Fredoka-SemiBold' não encontrada")
    }
    
    if let customFontLarge = UIFont(name: "Fredoka-SemiBold", size: 34) {
        appearance.largeTitleTextAttributes = [.font: customFontLarge]
    } else {
        print("⚠️ Fonte 'Fredoka-SemiBold' (large) não encontrada")
    }
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
}
