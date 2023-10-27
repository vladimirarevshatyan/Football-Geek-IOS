//
//  GetUefaStandingsUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation

class GetUefaStandingsUseCase : UseCase {
    
    @Inject private var standingsService:StandingsServiceImpl
    
    typealias Argument = Void
    typealias ReturnType = [String : [StandingTables]]
    
    
    func execute(argument: Void?) async -> [String : [StandingTables]] {
        let standings =   try? await  standingsService.getUefaStandings()
        return standings ?? [:]
    }
}
