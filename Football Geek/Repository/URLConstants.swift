//
//  URLConstants.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation


class URLConstants{
    
    //Other Standings
    static let apiKey = "&key=pciuTzhv7ywyqPIx&secret=SDcmBt9yH1xp2varItWB2e69MDIdsqKk"
    static let standingsBaseUrl = "https://livescore-api.com/api-client/leagues/table.json"
    static let standingsCompetitionUrl = "?competition_id="
    
    //UEFA Standings
    private static let uefaCompetitionIdUrl = "&competition_id=244"
    static let uefaApiKey = "?key=pciuTzhv7ywyqPIx&secret=SDcmBt9yH1xp2varItWB2e69MDIdsqKk"
    private static let groupA = "&group=A"
    private static let groupB = "&group=B"
    private static let groupC = "&group=C"
    private static let groupD = "&group=D"
    private static let groupE = "&group=E"
    private static let groupF = "&group=F"
    private static let groupG = "&group=G"
    private static let groupH = "&group=H"
    
    static let uefaStandingsA = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupA
    static let uefaStandingsB = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupB
    static let uefaStandingsC = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupC
    static let uefaStandingsD = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupD
    static let uefaStandingsE = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupE
    static let uefaStandingsF = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupF
    static let uefaStandingsG = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupG
    static let uefaStandingsH = standingsBaseUrl+uefaApiKey+uefaCompetitionIdUrl+groupH
}
