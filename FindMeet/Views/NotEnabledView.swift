//
//  NotEnabledView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 16/09/26.
//

import SwiftUI

struct NotEnabledView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            VStack(){
                Image("notEnable")
                    //.resizable()
                    .scaledToFit()
                    .padding(50)
                
                Text("Ihhh...dormiu, o Apple Intelligence não está ativado. Por favor, ative-o nos Ajustes, para acordá-lo.")
                    .font(.custom("Fredoka-Medium", size: 27))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
            }
            .padding(.bottom, 10)
            
            
        }
        
    }
}


#Preview {
    NotEnabledView()
}
