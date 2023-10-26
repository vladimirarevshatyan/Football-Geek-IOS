//
//  SettingsContract.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation


class SettingsEffect : UIEffect{
    
    class OnCacheToggleStateChange : SettingsEffect{
        let value:Bool
        init(value: Bool) {
            self.value = value
        }
    }
    
    class GetCacheToggleState : SettingsEffect{}
    
    class OnStandingsCacheTimeSelected : SettingsEffect{
        let id:String
        init(id: String) {
            self.id = id
        }
    }
    
    class GetUITexts : SettingsEffect{}
}
