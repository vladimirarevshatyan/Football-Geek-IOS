//
//  APIService.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation

protocol StandingsService{
    func getStandings(onSuccess:@escaping ([StandingsModel])->Void,onError:@escaping ()->Void)
}
