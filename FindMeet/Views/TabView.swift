//
//  TabView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct TelaView: View {
    
    let iconColor: Color = Color(red: 137/255, green: 13/255, blue: 13/255)
    var body: some View {
            TabView {
                GenerateMeetView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        
                    }
                SavedMeetView()
                    .tabItem {
                        Image(systemName: "filemenu.and.selection")
                        Text("")
                    }
            }
            .tint(Color(iconColor))
        }
        //.background(Color(backgroundColor))
        
    }

#Preview {
    TelaView()
}
