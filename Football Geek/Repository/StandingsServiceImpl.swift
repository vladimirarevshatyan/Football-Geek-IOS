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
    
    private let apiKey = "&key=pciuTzhv7ywyqPIx&secret=SDcmBt9yH1xp2varItWB2e69MDIdsqKk"
    private let baseUrl = "https://livescore-api.com/api-client/leagues/table.json"
    private let competitionUrl = "?competition_id="
    
    func getStandings(competition:Competition)async throws->StandingsModel{
        
        let url = baseUrl+competitionUrl+competition.rawValue+apiKey
        
        let urlComponents = URLComponents(string: url)
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(StandingsModel.self, from: data)
    }
}
