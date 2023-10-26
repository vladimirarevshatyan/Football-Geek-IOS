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
