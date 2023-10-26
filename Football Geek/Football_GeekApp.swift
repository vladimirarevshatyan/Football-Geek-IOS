//
//  Football_GeekApp.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import SwiftUI
import SwiftData

@main
struct Football_GeekApp: App {
    
    init(){
        initializeDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeContent()
        }
    }
}

private extension Football_GeekApp{
    
    func initializeDependencies(){
        module(moduleType: ModuleType.Single, moduleCall: {
            GetStandingsUseCase()
        })
        module(moduleType: ModuleType.Single, moduleCall: {
            GetCacheCanBeUsed()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            SaveCacheIsOnUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            StandingsServiceImpl()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            KeyValueStorage()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            LocalRepositoryImpl()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            TimeHelper()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetCompetitionsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            PersistenceController()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            GetLocalStandingsUseCase()
        })
        
        module(moduleType: ModuleType.Single, moduleCall: {
            RefreshLocalStandingsUseCase()
        })
    }
}
