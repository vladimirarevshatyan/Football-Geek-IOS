//
//  UseCaseModules.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation

class UseCaseModules : Module{
    
    init(){
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetStandingsCacheCanBeUsed()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            SaveCacheIsOnUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetCompetitionsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetLocalStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            RefreshLocalStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetLocalStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            RefreshLocalStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetUefaStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetLocalUefaStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetUefaStandingsCanBeUsed()
        })
    }
}
