//
//  FoundationModels.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import Foundation
import FoundationModels



protocol MeetGenerating {
    func generateMeet(for query: String) async throws -> Suggestion
}

final class FoundationModelsMeetGenerator: MeetGenerating {
    private var session: LanguageModelSession
    
    init() {
        let instructions = "Sua tarefa é planejar encontros românticos para o usuário. Responda sempre em português do Brasil."
        self.session = LanguageModelSession(instructions: instructions)
    }
    
    func generateMeet(for userQuery: String) async throws -> Suggestion {
        let request = userQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let prompt = """
        O usuário quer sugestões de encontro romântico com as seguintes preferências:
        \(request)
        
        Gere 3 opções de encontro que agradem as duas pessoas, combinando essas preferências. Todas as respostas em português do Brasil.
        """
        
        let response = try await session.respond(
            to: prompt,
            generating: Suggestion.self
        )
        return response.content
    }
}
