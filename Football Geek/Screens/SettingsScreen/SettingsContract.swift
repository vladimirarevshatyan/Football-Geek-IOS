//
//  SettingsContract.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation


enum SettingsEffect : UIEffect{
    
    case OnStandingsToggleStateChange(value:Bool)
    case OnUefaStandingsToggleStateChange(value:Bool)
    case GetCacheToggleState
    case OnStandingsCacheTimeSelected(id:String)
    case OnUefaStandingsCacheTimeSelected(id:String)
    case GetUITexts
}
