//
//  SettingsViewModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import CoreData


class SettingsViewModel : ViewModel<SettingsEffect>{
    
    @Published
    public var selectedCacheTimeText:String?
    
    @Inject
    private var saveCacheIsOnUseCase: SaveCacheIsOnUseCase
    @Inject
    private var getCacgeIsOnUseCase: GetCacheCanBeUsed
    @Inject
    private var localRepoHelper:KeyValueStorage
    @Inject
    private var timeHelper:TimeHelper
    
    @Published var isCacheOn:Bool = false
    
    override func handleEffect(effect: SettingsEffect) {
        
        switch(effect){
            
        case .OnCacheToggleStateChange(let value):
            saveToggleState(value: value)
            
        case .GetCacheToggleState:
            isCacheOn =  localRepoHelper.getCacheIsOn()
            
        case .OnStandingsCacheTimeSelected(let id):
            saveStandingCacheTime(id: id)
            
        case .GetUITexts:
            getSelectedCacheTimeText()
        }
    }
    
    private func saveToggleState(value:Bool){
        let previousValue = localRepoHelper.getCacheIsOn()
        if(previousValue != value){
            localRepoHelper.saveDouble(value: timeHelper.getCurrentMillis(), key: DefaultsKeys.standingsCacheMillis)
            Task {
                await self.saveCacheIsOnUseCase.execute(argument: value, result: {})
            }
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
    
    private func getSelectedCacheTimeText(){
        let settingsCacheTimeId = localRepoHelper.getString(key: DefaultsKeys.selectedStandingCacheTimeId)
        switch(settingsCacheTimeId){
        case DropDownTimeModel.OneHour:
            selectedCacheTimeText = "1 hour"
        case DropDownTimeModel.ThirtyMinutes:
            selectedCacheTimeText = "30 minutes"
        default:
            let thirtyMinutes = 30
            localRepoHelper.saveInt(value: thirtyMinutes, key: DefaultsKeys.selectedStandingsCacheTime)
            selectedCacheTimeText = "30 minutes"
        }
    }
}
