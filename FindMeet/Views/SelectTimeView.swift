//
//  SelectTimeView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 03/09/26.
//

import SwiftUI

struct SelectTimeView: View {
    
    @Bindable var flow: MeetFlowState
    @Binding var path: [MeetFlowRoute]
    @Environment(\.dismiss) var dismiss
    
    let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                Text("2/2")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Text("Qual o melhor \nhorario?")
                    .padding(20)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                
                
                InfiniteCarouselView(
                    items: MeetTimeEnum.allCases,
                    selected: $flow.selectedTime
                )
                
            
                HStack{
                    Spacer()
                    
                    Button {
                        
                        path.append(.loading)
                        
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                        //.frame(maxWidth: .infinity)
                            .padding(/*.vertical,*/ 16)
                            .background(Color(buttonColor))
                            .clipShape(Circle())
                            .shadow(color: Color.white.opacity(0.2),
                                    radius: 10,
                                    x: 0, y: 5)
                    }
                }
               
                .padding(.horizontal, 30)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectTimeView(flow: flow, path: $path)
}
