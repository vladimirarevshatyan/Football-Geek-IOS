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
    func saveStandings(standings:[StandingTables],competitionId:String)
}
