//
//  StandingsContract.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import Foundation

enum  StandingsEffect : UIEffect{
    case GetStandings
    case OnRefresh
    case GetCompetitions
    case OnCompetitionChosen(id:String,name:String)
}

