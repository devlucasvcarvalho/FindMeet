//
//  FoundationModels.swift
//  FindMeet
//
//  Created by Cintia Raquel on 01/09/26.
//

import Foundation
import FoundationModels



protocol MeetGenerating {
    func prewarm()
    func generateMeet(for dishQuery: String) async throws -> Suggestion
}

final class FoundationModelsMeetGenerator: MeetGenerating {
    private var session: LanguageModelSession

    init() {
        let instructions = "Your job is to plan romantic dates for the user."
        self.session = LanguageModelSession(instructions: instructions)
    }

    func prewarm() {
        session.prewarm()
    }

    func generateMeet(for userQuery: String) async throws -> Suggestion {
        //ira receber promptText por meio do parametro userQuery
        let request = userQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        //limpa espaços extras detectados
        
        let prompt = """
        Analyze the request: "\(request)".
        Generate 3 date options.
        """
        //monta o texto do prompt incluindo a entrada do usuario

        let response = try await session.respond(
            to: prompt,
            generating: Suggestion.self // Gera a struct Meet
        )
        //manda o prompt para a sessao modelo
        return response.content
    }
}
