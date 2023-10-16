//
//  StatsModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation


struct StatsModel : Decodable{
    let wins:Int
    let losses:Int
    let ties:Int
    let gamesPlayed:Int
    let goalsFor:Int
    let goalsAgainst:Int
    let points:Int
    let rank:Int
    let goalDifference:Int
}
