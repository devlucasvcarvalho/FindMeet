//
//  NotReadyView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 16/09/26.
//

import SwiftUI

struct NotReadyView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            VStack(){
                Image("notReady")
                    //.resizable()
                    .scaledToFit()
                    .padding(50)
                
                Text("Só mais cinco minutinhos… O modelo ainda está se preparando. Tente novamente daqui a pouco.")
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
    NotReadyView()
}
