//
//  UnknownReasonView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 16/09/26.
//

import SwiftUI

struct UnknownReasonView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()
            VStack(){
                Image("unknownReason")
                    //.resizable()
                    .scaledToFit()
                    .padding(50)
                
                Text("Ihh... algo inesperado aconteceu. Model não disponível por erro desconhecido.")
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
    UnknownReasonView()
}
