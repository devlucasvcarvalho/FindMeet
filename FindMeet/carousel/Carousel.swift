//
//  Carousel.swift
//  FindMeet
//
//  Created by Cintia Raquel on 30/08/26.
//

import SwiftUI

struct Carousel: View {
    @State private var items = [
        Items(id: 0, title: "First", color: Color.red),
        Items(id: 1, title: "Second", color: Color.green),
        Items(id: 2, title: "Third", color: Color.blue),
        Items(id: 3, title: "Fourth", color: Color.orange),
    ]
    
    var body: some View {
        InteractiveCarousel(items: $items) // Bind the array of items to the carousel component.
            .padding() // Add padding around the carousel for better layout.
    }
}


struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
