//
//  GetUefaStandingsCanBeUsed.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation


class GetUefaStandingsCanBeUsed: UseCase{
    
    typealias Argument = String
    typealias ReturnType = Bool
    
    
    @Inject private var localRepoHelper:KeyValueStorage
    @Inject private var timeHelper:TimeHelper
    @Inject private var localRepository:LocalRepositoryImpl
    
    
    func execute(argument: String?) async -> Bool {
        
        let millisForStandingCache =  self.localRepoHelper.getDouble(key: DefaultsKeys.uefaStandingsCacheMillis)
        let date =  timeHelper.dateFromDouble(double: millisForStandingCache)
        let diffInMinutes = timeHelper.differenceInMinutes(firstTime: date, secondTime: timeHelper.getCurrentDate())
        var threshold = localRepoHelper.getInt(key: DefaultsKeys.selecteUefadStandingCacheTime)
        
        if(threshold<=0){
            threshold = 30
        }
        
        let localItemsNotEmpty = await !localRepository.getUefaLocalStandings().isEmpty
        let uefaCacheIsOn = localRepoHelper.getBool(key: DefaultsKeys.uefaCacheOnKey)
        
        if(diffInMinutes<=threshold && uefaCacheIsOn && localItemsNotEmpty){
            return true
        }else{
            if(uefaCacheIsOn){
                localRepoHelper.saveDouble(value: timeHelper.getCurrentMillis(), key: DefaultsKeys.uefaStandingsCacheMillis)
            }
          return false
        }
    }
}
