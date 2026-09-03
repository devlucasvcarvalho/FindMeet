//
//  InputView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct InputView: View {
    let backgroundColor: Color = Color(red: 250/255, green: 221/255, blue: 221/255)
    var body: some View {
        ZStack{
            Color(backgroundColor)
                .ignoresSafeArea(edges: .all)
            Text("InputView")
                .navigationBarTitleDisplayMode(.inline)
            
        }
        .toolbarVisibility(.hidden, for: .tabBar)
       // .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InputView()
}
