//
//  StandingsServiceImpl.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation

class StandingsServiceImpl  :  StandingsService{
    
    private let newUrlRequest = "https://livescore-api.com/api-client/leagues/table.json?competition_id=2&key=pciuTzhv7ywyqPIx&secret=SDcmBt9yH1xp2varItWB2e69MDIdsqKk"
    
    func getStandings(onSuccess: @escaping (StandingsModel)->Void,onError: @escaping ()->Void){
        
        let urlComponents = URLComponents(string: newUrlRequest)
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            
            if let error = error {
                onError()
            }else if(data != nil){
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(StandingsModel.self, from: data!)
                    if(result.success){
                        onSuccess(result)
                    }else{
                        onError()
                    }
                } catch{
                    onError()
                }
            }
        }
        task.resume()
    }
}
