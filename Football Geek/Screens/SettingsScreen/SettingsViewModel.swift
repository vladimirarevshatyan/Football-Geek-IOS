//
//  SettingsViewModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import CoreData


class SettingsViewModel : ViewModel<SettingsEffect>{
    
    @Published var selectedStandingsCacheTime:String?
    @Published var selectedUefaCacheTime:String?
    
    @Inject
    private var saveCacheIsOnUseCase: SaveCacheIsOnUseCase
    @Inject
    private var getCacgeIsOnUseCase: GetStandingsCacheCanBeUsed
    @Inject
    private var localRepoHelper:KeyValueStorage
    @Inject
    private var timeHelper:TimeHelper
    
    @Published var isStandingsCacheOn:Bool = false
    @Published var isUefaStandingsCacheOn:Bool = false
    
    override func handleEffect(effect: SettingsEffect) {
        
        switch(effect){
            
        case .OnStandingsToggleStateChange(let value):
            saveStandingsToggleState(value: value)
            
        case .OnUefaStandingsToggleStateChange(let value):
            saveUefaToggleState(value: value)
            
        case .GetCacheToggleState:
            isStandingsCacheOn =  localRepoHelper.getCacheIsOn()
            isUefaStandingsCacheOn =  localRepoHelper.getBool(key: DefaultsKeys.uefaCacheOnKey)
            
        case .OnStandingsCacheTimeSelected(let id):
            saveStandingCacheTime(id: id)
            
        case .OnUefaStandingsCacheTimeSelected(let id):
            saveUefaStandingCacheTime(id: id)
            
        case .GetUITexts:
            getSelectedCacheTimeText()
            getSelectedUefaCacheTimeText()
        }
    }
    
    private func saveStandingsToggleState(value:Bool){
        let previousValue = localRepoHelper.getCacheIsOn()
        if(previousValue != value){
            localRepoHelper.saveDouble(value: timeHelper.getCurrentMillis(), key: DefaultsKeys.standingsCacheMillis)
            Task {
                await self.saveCacheIsOnUseCase.execute(argument: value, result: {})
            }
        }
    }
    
    private func saveUefaToggleState(value:Bool){
        let previousValue = localRepoHelper.getBool(key: DefaultsKeys.uefaCacheOnKey)
        if(previousValue != value){
            localRepoHelper.saveDouble(value: timeHelper.getCurrentMillis(), key: DefaultsKeys.uefaStandingsCacheMillis)
            localRepoHelper.saveBool(value: value, key: DefaultsKeys.uefaCacheOnKey)
        }
    }
    
    private func saveStandingCacheTime(id:String){
        
        localRepoHelper.saveString(value: id, key: DefaultsKeys.selectedStandingCacheTimeId)
        
        switch(id){
            
        case DropDownTimeModel.OneHour:
            let oneHourInMinutes = 60
            localRepoHelper.saveInt(value: oneHourInMinutes, key: DefaultsKeys.selectedStandingsCacheTime)
        case DropDownTimeModel.ThirtyMinutes:
            let thirtyMinutes = 30
            localRepoHelper.saveInt(value: thirtyMinutes, key: DefaultsKeys.selectedStandingsCacheTime)
        default:
            Void()
            
        }
        getSelectedCacheTimeText()
    }
    
    
    private func saveUefaStandingCacheTime(id:String){
        
        localRepoHelper.saveString(value: id, key: DefaultsKeys.selecteUefadStandingCacheTimeId)
        
        switch(id){
            
        case DropDownTimeModel.OneHour:
            let oneHourInMinutes = 60
            localRepoHelper.saveInt(value: oneHourInMinutes, key: DefaultsKeys.selecteUefadStandingCacheTime)
        case DropDownTimeModel.ThirtyMinutes:
            let thirtyMinutes = 30
            localRepoHelper.saveInt(value: thirtyMinutes, key: DefaultsKeys.selecteUefadStandingCacheTime)
        default:
            Void()
            
        }
        getSelectedUefaCacheTimeText()
    }
    
    private func getSelectedCacheTimeText(){
        let settingsCacheTimeId = localRepoHelper.getString(key: DefaultsKeys.selectedStandingCacheTimeId)
        switch(settingsCacheTimeId){
        case DropDownTimeModel.OneHour:
            selectedStandingsCacheTime = "1 hour"
        case DropDownTimeModel.ThirtyMinutes:
            selectedStandingsCacheTime = "30 minutes"
        default:
            let thirtyMinutes = 30
            localRepoHelper.saveInt(value: thirtyMinutes, key: DefaultsKeys.selectedStandingsCacheTime)
            selectedStandingsCacheTime = "30 minutes"
        }
    }
    
    private func getSelectedUefaCacheTimeText(){
        let settingsCacheTimeId = localRepoHelper.getString(key: DefaultsKeys.selecteUefadStandingCacheTimeId)
        switch(settingsCacheTimeId){
        case DropDownTimeModel.OneHour:
            selectedUefaCacheTime = "1 hour"
        case DropDownTimeModel.ThirtyMinutes:
            selectedUefaCacheTime = "30 minutes"
        default:
            let thirtyMinutes = 30
            localRepoHelper.saveInt(value: thirtyMinutes, key: DefaultsKeys.selecteUefadStandingCacheTimeId)
            selectedUefaCacheTime = "30 minutes"
        }
    }
}
