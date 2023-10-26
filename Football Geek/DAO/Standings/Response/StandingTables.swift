//
//  StandingTables.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/18/23.
//

import Foundation


struct StandingTables : Decodable{
    let leagueId:String
    let seasonId:String
    let name:String
    let rank:String
    let points:String
    let matches:String
    let goalDiff:String
    let goalsScored:String
    let goalsConceded:String
    let lost:String
    let drawn:String
    let won:String
    let teamId:String
    let competitionId:String
    let groupId:String
    let groupName:String
    let stageName:String
    let stageId:String
}
