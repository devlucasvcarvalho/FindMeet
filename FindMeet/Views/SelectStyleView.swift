//
//  InputView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import SwiftUI

struct SelectStyleView: View {
    
    
    @Bindable var flow: MeetFlowState
    @Binding var path: [MeetFlowRoute]
    @Environment(\.dismiss) var dismiss
    
    let buttonColor: Color = Color(red: 144/255, green: 3/255, blue: 3/255)
    
    @State private var selectedStyle: MeetStyleEnum = .festive
    
    // String que será armazenada quando o usuário clicar em "Selecionar"
    @State private var selectedStyleString: String = ""
    private let buttonCircleColor = Color.black.opacity(0.05)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("1/2")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                
                Text("Qual atividade tem \n em mente?")
                    .padding(20)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                
                InfiniteCarouselView(
                    items: MeetStyleEnum.allCases,
                    selected: $flow.selectedStyle
                )
                //                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
              //  HStack{
                    //Spacer()
                    
                    Button {
                        
                        selectedStyleString = selectedStyle.styles
                        path.append(.selectTime)
                        
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
                //}
                .padding(.horizontal,30)
            }
        
               
            }
        .toolbar(.hidden, for: .tabBar)
        }
    }



// MARK: - Preview

#Preview {
    @Previewable @State var flow = MeetFlowState()
    @Previewable @State var path: [MeetFlowRoute] = []
    
    SelectStyleView(flow: flow, path: $path)
}
