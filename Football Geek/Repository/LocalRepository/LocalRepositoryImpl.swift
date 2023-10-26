//
//  CoreDataImpl.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import CoreData
import SwiftUI

class LocalRepositoryImpl : LocalRepository{
    
    @Inject private var persistenceController:PersistenceController
    
    func saveStandings(standings: [StandingTables],competitionId:String) {
        
        let mockEnvo = persistenceController.container.viewContext
        
        mockEnvo.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        ForEach(standings){ model in 
            
        }
        
        standings.map { model in
            
            let daoObject = StandingsUIDao(context: mockEnvo)
            daoObject.id = model.name
            daoObject.position = model.rank
            daoObject.name = model.name
            daoObject.win = model.won
            daoObject.draw = model.drawn
            daoObject.lose = model.lost
            daoObject.points = model.points
            daoObject.matches = model.matches
            daoObject.competitionId = competitionId
        }
        
        do {
            try mockEnvo.save()
        } catch {
            print(error)
        }
    }

    
    func getLocalStandings()-> [StandingsUIDao]{
        
    }
    
    func refreshData(){
        persistenceController.container.viewContext.refreshAllObjects()
    }
}
