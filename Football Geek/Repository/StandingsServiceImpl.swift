//
//  StandingsServiceImpl.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation
import SwiftUI
import CoreData

class StandingsServiceImpl : StandingsService{
    @Inject
    private var localRepository:LocalRepositoryImpl
    
    func getStandings(competition:Competition)async throws->StandingsModel{
        
        let url = URLConstants.standingsBaseUrl+URLConstants.standingsCompetitionUrl+competition.rawValue+URLConstants.apiKey
        
        let urlComponents = URLComponents(string: url)
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try getDecoder().decode(StandingsModel.self, from: data)
    }
    
    func getUefaStandings() async throws -> [String: [StandingTables]] {
        
        //A
        let standingsURLgroupA = getUrlRequest(url: URLConstants.uefaStandingsA)
        let (groupDataA, _) = try await URLSession.shared.data(for: standingsURLgroupA)
        let standingsGroupA = try getDecoder().decode(StandingsModel.self, from: groupDataA)
        
        //B
        let standingsURLgroupB = getUrlRequest(url: URLConstants.uefaStandingsB)
        let (groupDataB, _) = try await URLSession.shared.data(for: standingsURLgroupB)
        let standingsGroupB = try getDecoder().decode(StandingsModel.self, from: groupDataB)
        //C
        let standingsURLgroupC = getUrlRequest(url: URLConstants.uefaStandingsC)
        let (groupDataC, _) = try await URLSession.shared.data(for: standingsURLgroupC)
        let standingsGroupC = try getDecoder().decode(StandingsModel.self, from: groupDataC)
        //D
        let standingsURLgroupD = getUrlRequest(url: URLConstants.uefaStandingsD)
        let (groupDataD, _) = try await URLSession.shared.data(for: standingsURLgroupD)
        let standingsGroupD = try getDecoder().decode(StandingsModel.self, from: groupDataD)
        //E
        let standingsURLgroupE = getUrlRequest(url: URLConstants.uefaStandingsE)
        let (groupDataE, _) = try await URLSession.shared.data(for: standingsURLgroupE)
        let standingsGroupE = try getDecoder().decode(StandingsModel.self, from: groupDataE)
        //F
        let standingsURLgroupF = getUrlRequest(url: URLConstants.uefaStandingsF)
        let (groupDataF, _) = try await URLSession.shared.data(for: standingsURLgroupF)
        let standingsGroupF = try getDecoder().decode(StandingsModel.self, from: groupDataF)
        //G
        let standingsURLgroupG = getUrlRequest(url: URLConstants.uefaStandingsG)
        let (groupDataG, _) = try await URLSession.shared.data(for: standingsURLgroupG)
        let standingsGroupG = try getDecoder().decode(StandingsModel.self, from: groupDataG)
        //H
        let standingsURLgroupH = getUrlRequest(url: URLConstants.uefaStandingsH)
        let (groupDataH, _) = try await URLSession.shared.data(for: standingsURLgroupH)
        let standingsGroupH = try getDecoder().decode(StandingsModel.self, from: groupDataH)
        
        let uefaStandings = [
            "A":standingsGroupA.data.table,
            "B":standingsGroupB.data.table,
            "C":standingsGroupC.data.table,
            "D":standingsGroupD.data.table,
            "E":standingsGroupE.data.table,
            "F":standingsGroupF.data.table,
            "G":standingsGroupG.data.table,
            "H":standingsGroupH.data.table,
        ]
        
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupA.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupB.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupC.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupD.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupE.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupF.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupG.data.table)
        await localRepository.saveUefaLocalStandings(uefaStandings: standingsGroupH.data.table)
        
        return uefaStandings
    }
    
    private func getUrlRequest(url:String) -> URLRequest{
        let urlComponents = URLComponents(string: url)
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        return request;
    }
    
    private func getDecoder()->JSONDecoder{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder;
    }
}
