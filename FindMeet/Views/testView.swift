//
//  testView.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 31/08/26.
//

import MapKit
import FoundationModels
import Foundation
import SwiftUI

struct SearchPlacesView: View {
    @State private var myPrompt = ""

    @State private var responseError: String?
    @State private var searchResult: SearchPlacesOutput?

    @State private var isLoading = false

    private let session = LanguageModelSession(
        tools: [SearchPlacesTool()],
        instructions: "Help the user find places."
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Encontrar lugares")
                        TextField("Digite aqui seu prompt", text: $myPrompt)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                Button("Pesquisar") {
                    Task {
                        searchResult = nil
                        responseError = nil
                        await search()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(myPrompt.isEmpty || isLoading)
                
                
                if isLoading {
                    ProgressView()
                }
                
                if let searchResult {
                    Section {
                        ForEach(searchResult.places, id: \.name) { place in
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Label(place.name, systemImage: "mappin.circle.fill")
                                    .font(.headline)
                                
                                Text(place.address)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .textSelection(.enabled)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    } header: {
                         Text("Resultados")
                             .font(.headline)
                     }
                }
                
                if let responseError {
                    Text(responseError)
                        .padding()
                        .background(Color.red)
                }
            }
            .padding()
        }
    }
    
    func search() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await session.respond(
                to: myPrompt,
                generating: SearchPlacesOutput.self
            )
            searchResult = result.content
        } catch {
            responseError = error.localizedDescription
        }
    }
}

#Preview("Search Places Tool") {
    SearchPlacesView()
}
