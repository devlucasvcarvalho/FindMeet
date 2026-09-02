////
////  PickersView.swift
////  FindMeet
////
////  Created by Cintia Raquel on 01/09/26.
////
//import SwiftUI
//
//struct Card: View {
//    let data: Meet
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Header with profile and action buttons
//            HStack {
//                Image(data.title)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 42, height: 42)
//                    .clipShape(.circle)
//                
//                Spacer()
//                
//                // Like button
//                Circle()
//                    .fill(Color.white.opacity(0.1))
//                    .frame(width: 42, height: 42)
//                    .overlay {
//                        Image(systemName: "heart.fill")
//                            .foregroundColor(.white.opacity(0.8))
//                    }
//                
//                // Comment button
//                Circle()
//                    .fill(Color.white.opacity(0.1))
//                    .frame(width: 42, height: 42)
//                    .overlay {
//                        Image(systemName: "message.fill")
//                            .foregroundColor(.white.opacity(0.8))
//                    }
//            }
//            
//            // Rest of the card content...
//            Text(data.description)
//                .font(.system(size: 24, weight: .bold))
//            
//            // Footer with title and salary
//            Text(data.tip)
//                .font(.system(size: 18, weight: .bold))
//            
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Senior")
//                        .font(.system(size: 32, weight: .bold))
//                }
//                
//                Spacer()
//                
//                Text("More")
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 12)
//                    .background(.black)
//                    .cornerRadius(100)
//            }
//        }
//        .padding(16)
////        .background(data.backgroundColor)
//        .cornerRadius(30)
//    }
//}
