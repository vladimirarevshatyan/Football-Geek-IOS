//
//  CoreData.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import SwiftUI
import CoreData

protocol LocalRepository {
    func saveStandings(standings:[StandingTables],competitionId:String) async
    func getLocalStandings(competitionId:String)async -> [StandingsLocalModel]
    func getUefaLocalStandings() async -> [UefaStandingsLocalModel]
    func saveUefaLocalStandings(uefaStandings:[StandingTables]) async
    func refreshData() async
}
