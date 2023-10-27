//
//  APIService.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation
import SwiftUI
import CoreData

protocol StandingsService{
    func getStandings(competition:Competition)async throws->StandingsModel
    func getUefaStandings() async throws -> [String: [StandingTables]]
}
