//
//  GetStandingsUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation
import SwiftUI
import CoreData


class GetStandingsUseCase : UseCase{
    
    typealias ReturnType = [StandingTables]
    typealias ErrorType = NetworkError
    typealias Argument = Competition
    
    @Inject private var localRepository:LocalRepositoryImpl
    
    
    @Inject private var standingsService:StandingsServiceImpl
    
    func execute(argument: Competition?) async -> [StandingTables] {
        let standings =  try? await standingsService.getStandings(competition: argument ?? Competition.EnglishPremierLeague)
        
        if(standings != nil){
            await localRepository.saveStandings(standings: standings?.data.table ?? [], competitionId: argument?.rawValue ?? Competition.EnglishPremierLeague.rawValue)
        }
        
        return standings?.data.table ?? []
    }
}
