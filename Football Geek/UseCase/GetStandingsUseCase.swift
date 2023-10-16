//
//  GetStandingsUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation


class GetStandingsUseCase : UseCase{
    
    init(standingsService: StandingsService) {
        self.standingsService = standingsService
    }
    
    private let standingsService:StandingsService
    
    typealias ReturnType = [StandingsModel]
    
    func execute(onSuccess: @escaping ([StandingsModel]) -> Void, onError:@escaping () -> Void) {
        standingsService.getStandings(onSuccess: onSuccess, onError: onError)
    }
}
