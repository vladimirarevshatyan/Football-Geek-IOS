//
//  StandingsModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation

struct StandingsModel : Decodable{
    let team:TeamModel
    let stats:StatsModel
}
