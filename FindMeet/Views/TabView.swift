//
//  TabView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct TelaView: View {
    
    @State private var selectedTab: Int = 0
    let iconColor: Color = Color(red: 137/255, green: 13/255, blue: 13/255)
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GenerateMeetView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "heart.fill")
                }
                .tag(0)
            
            SavedMeetView()
                .tabItem {
                    Image(systemName: "filemenu.and.selection")
                    Text("")
                }
                .tag(1)
        }
        .tint(iconColor)
    }
}
#Preview {
    TelaView()
}
