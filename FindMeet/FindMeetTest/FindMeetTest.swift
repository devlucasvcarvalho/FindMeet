//
//  FindMeetTest.swift
//  FindMeetTest
//
//  Created by Cintia Raquel on 17/09/26.
//

import Testing
//importar o meu projeto
@testable import FindMeet

@Test
//criar uma funcao para testar cada funcionalidade
func testarFoundationModels() async throws {
    //fazer uma constante chamando a classe para testar
    let generator = FoundationModelsMeetGenerator()
    //puxando a funcao especifica
        let suggestion = try await generator.generateMeet(for: "jantar romântico, orçamento médio, à noite")
    //
    #expect(suggestion != nil)
}

