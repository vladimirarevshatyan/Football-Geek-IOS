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
    
    func saveStandings(standings: [StandingTables],competitionId:String) async {
        
        let mockEnvo = persistenceController.context
        
        mockEnvo.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        let _ = standings.map { model in
            
            let daoObject = StandingsLocalModel(context: mockEnvo)
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

    
    func getLocalStandings(competitionId:String) async -> [StandingsLocalModel]{
        
        let fetchRequest: NSFetchRequest<StandingsLocalModel> = StandingsLocalModel.standingsFetchRequest
           let search = NSPredicate(format: "competitionId CONTAINS %@", competitionId)
           fetchRequest.predicate = search
           do {
               let predicateItem =  try persistenceController.context.fetch(fetchRequest)
               return predicateItem
           } catch {
               return []
           }
    }
    
    func refreshData() async{
        persistenceController.context.refreshAllObjects()
    }
}
