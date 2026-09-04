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
        let request = userQuery.trimmingCharacters(in: .whitespacesAndNewlines)

        let prompt = """
        O usuário quer sugestões de encontro romântico com as seguintes preferências:
        \(request)

        Gere 3 opções de encontro que combinem com essas preferências.
        """

        let response = try await session.respond(
            to: prompt,
            generating: Suggestion.self
        )
        return response.content
    }
}
