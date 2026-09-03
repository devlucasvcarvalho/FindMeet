//
//  LoadingView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//
import SwiftUI

struct LoadingView: View {
    let selectedStyle: MeetStyleEnum
    let selectedTime: MeetTimeEnum

    var body: some View {
        Text("Gerando seu encontro...")
            .onAppear {
                let style = selectedStyle.styles
                let time = selectedTime.time

                print("Estilo: \(style)")
                print("Horário: \(time)")

                // montar prompt do Foundation Model
            }
    }
}
