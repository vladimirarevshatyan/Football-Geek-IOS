//
//  GetLocalUefaStandingsUsecAse.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation

class GetLocalUefaStandingsUseCase: UseCase {
    
    @Inject private var localRepository:LocalRepositoryImpl
    
    typealias Argument = Void
    typealias ReturnType = [String : [UefaStandingsLocalModel]]
    
    
    func execute(argument: Void?) async -> [String : [UefaStandingsLocalModel]] {
        return await localRepository.getUefaLocalStandings().asUefaGrouped()
    }
}
