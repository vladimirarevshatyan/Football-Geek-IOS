//
//  GetCacheIsOnUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import CoreData


class GetCacheCanBeUsed : UseCase{

    typealias Argument = String
    typealias ReturnType = Bool
    
    
    @Inject private var localRepoHelper:KeyValueStorage
    @Inject private var timeHelper:TimeHelper
    @Inject private var localRepository:LocalRepositoryImpl
    
    
    func execute(argument: String?) async -> Bool {
        
        let millisForStandingCache =  self.localRepoHelper.getDouble(key: DefaultsKeys.standingsCacheMillis)
        let date =  timeHelper.dateFromDouble(double: millisForStandingCache)
        let diffInMinutes = timeHelper.differenceInMinutes(firstTime: date, secondTime: timeHelper.getCurrentDate())
        var threshold = localRepoHelper.getInt(key: DefaultsKeys.selectedStandingsCacheTime)
        
        if(threshold<=0){
            threshold = 30
        }
        
        let localItemsNotEmpty = await !localRepository.getLocalStandings(competitionId: argument ?? Competition.EnglishPremierLeague.rawValue).isEmpty
        
        if(diffInMinutes<=threshold && localRepoHelper.getCacheIsOn() && localItemsNotEmpty){
            return true
        }else{
            if(localRepoHelper.getCacheIsOn()){
                localRepoHelper.saveDouble(value: timeHelper.getCurrentMillis(), key: DefaultsKeys.standingsCacheMillis)
            }
          return false
        }
    }
}
