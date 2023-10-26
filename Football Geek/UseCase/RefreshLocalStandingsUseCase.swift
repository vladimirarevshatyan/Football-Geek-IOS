//
//  RefreshLocalStandingsUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation


class RefreshLocalStandingsUseCase : UseCase{
    
    @Inject private var localRepository:LocalRepositoryImpl
        
    typealias Argument = Void?
    typealias ReturnType = Void?
    
    func execute(argument: Void??) async -> Void? {
       await localRepository.refreshData()
    }
}
