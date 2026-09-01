//
//  findPlacesTool.swift
//  FindMeet
//
//  Created by Lucas Vieira de Carvalho on 31/08/26.
//

//import MapKit
//import FoundationModels
//import Foundation
//
//struct FindPlacesTool: Tool{
//    let name: String = "findPlaces"
//    let description: String = "Finds places in a given area"
//    
//    @Generable
//    struct SearchPlacesArguments {
//        @Guide(description: "The city to search in")
//        let city: String
//        
//        @Guide(description: "The type of place to search for")
//        let query: String
//    }
//    
//    func call(arguments: SearchPlacesArguments) async throws -> SearchMeetsOutput {
//        
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = "\(arguments.query) in \(arguments.city)"
//        
//        let response = try await MKLocalSearch(request: request).start()
//        
//        let places = response.mapItems.prefix(5).map { item in
//            Meet(
//                title: "Unknown",
//                description: "Teste",
//                tip: item.address?.description ?? "Unknown address"
//            )
//        }
//        //    func run(using context: CommandContext) throws -> EventLoopFuture<Void> {
//        //        let location = try context.requireArgument(name: "location", type: CLLocationCoordinate2D.self)
//        //        let radius = try context.requireArgument(name: "radius", type: Int.self)
//        //    }
//        
//    }
//    return 
//}

