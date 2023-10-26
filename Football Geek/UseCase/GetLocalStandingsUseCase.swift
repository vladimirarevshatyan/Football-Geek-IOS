//
//  GetLocalStandingsUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/26/23.
//

import Foundation


class GetLocalStandingsUseCase : UseCase{
    
    typealias Argument = String
    typealias ReturnType = [StandingsLocalModel]
    
    @Inject private var localRepository:LocalRepositoryImpl
    
    func execute(argument: String?) async -> [StandingsLocalModel] {
        let localStandings = await localRepository.getLocalStandings(competitionId: argument ?? Competition.EnglishPremierLeague.rawValue)
        return localStandings
    }
}
