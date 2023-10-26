//
//  TimeHelper.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/20/23.
//

import Foundation

class TimeHelper{
    
    @Inject
    private var localRepoHelper:KeyValueStorage
    
    func getCurrentMillis()->Double{
        let date = Date()
        return Double(date.timeIntervalSince1970 * 1000)
    }
    
    func getCurrentDate()->Date{
        return Date()
    }
    
    func saveCurrentTime(key:String){
        let currentTiem = getCurrentMillis()
        localRepoHelper.saveDouble(value: currentTiem, key: key)
    }
    
    func differenceInMinutes(firstTime:Date,secondTime:Date)->Int{
        let diffMinutes = (firstTime.timeIntervalSince1970*1000).distance(to:(secondTime.timeIntervalSince1970*1000))
        let seconds = diffMinutes / 1000
        let minutes = seconds / 60
        return Int(minutes)
    }
    
    func differenceInSeconds(firstTime:Date,secondTime:Date)->Double{
        let diffMinutes = (firstTime.timeIntervalSince1970*1000).distance(to:(secondTime.timeIntervalSince1970*1000))
        let seconds = diffMinutes / 1000
        return seconds
    }
    
    func dateFromDouble(double:Double)->Date{
        return Date(timeIntervalSince1970: double/1000)
    }
}
