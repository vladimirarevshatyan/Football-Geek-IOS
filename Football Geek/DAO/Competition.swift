//
//  Competition.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/26/23.
//

import Foundation


enum Competition : String,CaseIterable {
    case EnglishPremierLeague = "2"
    case SerieACompetition = "4"
    case LaLigaSantander = "3"
}

extension Competition{
    func getCompetitionName()->String{
        switch(self){
            
        case .EnglishPremierLeague:
            return "English Premier League"
        case .SerieACompetition:
            return "Serie A"
        case .LaLigaSantander:
            return "LaLiga Santander"
        }
    }
}
