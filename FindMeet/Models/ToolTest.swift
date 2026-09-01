//
//  ToolTest.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 31/08/26.
//

import MapKit
import FoundationModels
import Foundation

struct SearchPlacesTool: Tool {
    let name = "searchPlaces"
    let description = "Searches for places in a city."
    
    @Generable
    struct SearchPlacesArguments {
        @Guide(description: "The city to search in")
        let city: String

        @Guide(description: "The type of place to search for")
        let query: String
    }

    func call(arguments: SearchPlacesArguments) async throws -> SearchPlacesOutput {

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(arguments.query) in \(arguments.city)"

        let response = try await MKLocalSearch(request: request).start()

        let places = response.mapItems.prefix(5).map { item in
            Place(
                name: item.name ?? "Unknown",
                address: item.address?.description ?? "Unknown address"
            )
        }

        return SearchPlacesOutput(
            places: Array(places)
        )
    }
}
