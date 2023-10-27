//
//  LocalRepoHelper.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation


class KeyValueStorage{
    
    let defaults = UserDefaults.standard
    
    func getCacheIsOn()->Bool{
        return defaults.bool(forKey: DefaultsKeys.cacheOnKey)
    }
    
    func setCacheIsOn(value:Bool){
        let defaults = UserDefaults.standard
        defaults.set(
            value,
            forKey: DefaultsKeys.cacheOnKey
        )
    }
    
    func getBool(key:String)->Bool{
        return defaults.bool(forKey: key)
    }
    
    func saveBool(value:Bool,key:String){
        let defaults = UserDefaults.standard
        defaults.set(
            value,
            forKey: key
        )
    }
    
    func saveDouble(value:Double,key:String){
        let defaults = UserDefaults.standard
        defaults.set(
            value,
            forKey: key
        )
    }
    
    func getDouble(key:String)->Double{
        return defaults.double(forKey: key)
    }
    
    
    func saveInt(value:Int,key:String){
        let defaults = UserDefaults.standard
        defaults.set(
            value,
            forKey: key
        )
    }
    
    func getInt(key:String)->Int{
        return defaults.integer(forKey: key)
    }
    
    
    func saveString(value:String,key:String){
        let defaults = UserDefaults.standard
        defaults.set(
            value,
            forKey: key
        )
    }
    
    func getString(key:String)->String?{
        return defaults.string(forKey: key)
    }
}

struct DefaultsKeys {
    static let cacheOnKey = "isCacheOn"
    static let uefaCacheOnKey = "uefaCacheOn"
    static let standingsCacheMillis = "standing_cache_millis"
    static let uefaStandingsCacheMillis = "uefa_standing_cache_millis"
    static let selectedStandingCacheTimeId = "selected_standing_cache_time_id"
    static let selecteUefadStandingCacheTimeId = "selected_uefa_standing_cache_time_id"
    static let selecteUefadStandingCacheTime = "selected_uefa_standing_cache_time"
    static let selectedStandingsCacheTime = "selected_standing_cache_time"
    static let chosenCompetitionId = "chosen_competition_id"
}
