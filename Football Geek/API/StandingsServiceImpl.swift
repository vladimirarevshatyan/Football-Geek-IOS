//
//  StandingsServiceImpl.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation

class StandingsServiceImpl  :  StandingsService{
    
    private let url = "https://premier-league-standings1.p.rapidapi.com/"
    private let seasonQueryParam = "season"
    private let headerParamValue = "54e7b837e0msh7ff5d0d2242e5b8p14ca15jsn88cecfb0a85d"
    private let headerParamKey = "X-RapidAPI-Key"
    
    func getStandings(onSuccess: @escaping ([StandingsModel])->Void,onError: @escaping ()->Void){

        var urlComponents = URLComponents(string: url)

        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: seasonQueryParam, value: "2023"))

        urlComponents?.queryItems = queryItems

        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"

        request.setValue(headerParamValue, forHTTPHeaderField: headerParamKey)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
           
            if(data != nil){
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([StandingsModel].self, from: data!)
                    onSuccess(result)
                } catch{
                   onError()
                }
            }
        }
        task.resume()
    }
}
