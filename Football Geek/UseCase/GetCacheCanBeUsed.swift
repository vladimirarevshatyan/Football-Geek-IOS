//
//  GetCacheIsOnUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import CoreData


class GetCacheCanBeUsed : UseCase{
    
    typealias LocalDataReturnType = Void
    
    
    @Inject 
    private var localRepoHelper:LocalRepoHelper
    @Inject
    private var timeHelper:TimeHelper
    
    typealias ReturnType = Bool
    
    typealias ErrorType = Void
    
    func execute(onSuccess: @escaping (Bool) -> Void, onError: @escaping (Void) -> Void) {
        let millisForStandingCache =  self.localRepoHelper.getDouble(key: DefaultsKeys.standingsCacheMillis)
        let date =  timeHelper.dateFromDouble(double: millisForStandingCache)
        let diffInSeconds = timeHelper.differenceInSeconds(firstTime: date, secondTime: timeHelper.getCurrentDate())
        
        if(diffInSeconds<=25 && localRepoHelper.getCacheIsOn()){
            onSuccess(true)
        }else{
            onSuccess(false)
        }
    }
    
    func setMockEnvo(mockEnvo: NSManagedObjectContext) {}
}
