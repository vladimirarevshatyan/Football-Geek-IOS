//
//  Extensions.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/20/23.
//

import Foundation
import CoreData

extension StandingsLocalModel {
    
    static var standingsFetchRequest: NSFetchRequest<StandingsLocalModel> {
        let request: NSFetchRequest<StandingsLocalModel> = StandingsLocalModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
        return request
    }
}

extension UefaStandingsLocalModel{
    static var uefaFetchRequest: NSFetchRequest<UefaStandingsLocalModel> {
        let request: NSFetchRequest<UefaStandingsLocalModel> = UefaStandingsLocalModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "rank", ascending: true)]
        return request
    }
}

extension [String:[StandingTables]]{
    
    func asUefaStandingsUIModel()->[String:[UefaStandingsUIModel]]{
        return self.mapValues { value in
            return  value.map { standingTable in
                UefaStandingsUIModel(
                    name: standingTable.name,
                    position: standingTable.rank,
                    points: standingTable.points,
                    gamesPlayed: standingTable.matches,
                    groupName: standingTable.groupName
                )
            }
        }
    }
}

extension [String:[UefaStandingsLocalModel]]{
    
    func asUefaStandingsUIModel()->[String:[UefaStandingsUIModel]]{
        return self.mapValues { value in
            return  value.map { standingTable in
                UefaStandingsUIModel(
                    name: standingTable.name ?? "",
                    position: standingTable.rank ?? "",
                    points: standingTable.points ?? "",
                    gamesPlayed: standingTable.matches ?? "" ,
                    groupName: standingTable.groupName ?? ""
                )
            }
        }
    }
}

extension [UefaStandingsLocalModel]{
    
    func asUefaStandingsUImodel()->[String:[UefaStandingsUIModel]] {
        let uefaUiModels = self.map { uefaLocalModel in
            UefaStandingsUIModel(
                name: uefaLocalModel.name ?? "",
                position: uefaLocalModel.rank ?? "",
                points: uefaLocalModel.points ?? "",
                gamesPlayed: uefaLocalModel.matches ?? "",
                groupName: uefaLocalModel.groupName ?? ""
            )
        }
        return uefaUiModels.group { model in
            model.groupName
        }
    }
    
    func asUefaGrouped()->[String:[UefaStandingsLocalModel]] {
        return self.group { model in
            model.groupName ?? "A"
        }
    }
}



extension [StandingsLocalModel]{
    
    func asStandingsUIModel()->[StandingsUIModel]{
        return self.map { standingsLocalModel in
            StandingsUIModel(
                id: standingsLocalModel.id ?? "",
                position: standingsLocalModel.position ?? "",
                name: standingsLocalModel.name ?? "",
                win: standingsLocalModel.win ?? "",
                draw: standingsLocalModel.draw ?? "",
                lose: standingsLocalModel.lose ?? "",
                points: standingsLocalModel.points ?? "",
                matches: standingsLocalModel.matches ?? ""
            )
        }
    }
}
