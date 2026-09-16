//
//  NotEligibleView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 16/09/26.
//

import SwiftUI

struct NotEligibleView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            VStack(){
                Image("notEligible")
                    //.resizable()
                    .scaledToFit()
                    .padding(50)
                
                Text("Essa doeu no coração… Seu dispositivo não é compatível com a Apple Intelligence.")
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
    NotEligibleView()
}
