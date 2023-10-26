//
//  StandingScreenViewModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import Foundation
import SwiftUI
import CoreData

class StandingScreenViewModel : ViewModel<StandingsEffect>{
    
    @Inject private var getStandingsUseCase:GetStandingsUseCase
    @Inject private var getCanUseCache:GetCacheCanBeUsed
    @Inject private var timeHelper:TimeHelper
    @Inject private var localRepoHelper:LocalRepoHelper
    
    private var mockEnvo:NSManagedObjectContext?
    
    @Published var standingsUiModel:[StandingsUIModel] = []
    @Published var isLoading:Bool = false;
    @Published var errorMessage:String? = nil
    @Published var useCache:Bool = false
    
    private func getStandings(){
        self.errorMessage = nil
        
        getCanUseCache.execute { useCache in
            
            DispatchQueue.main.async {
                self.useCache = useCache
            }
            
            if(!useCache){
                self.getStandingsUseCase.execute { models in
                    let finalStandings =  models.data.table.map { standingsModel in
                        return StandingsUIModel(
                            id:standingsModel.teamId,
                            position: standingsModel.rank,
                            name: standingsModel.name,
                            win:standingsModel.won,
                            draw:standingsModel.drawn,
                            lose:standingsModel.lost,
                            points:standingsModel.points,
                            matches: standingsModel.matches
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self.standingsUiModel = finalStandings.sorted { $1.position.codingKey.intValue ?? 0 > $0.position.codingKey.intValue ?? 0}
                        self.isLoading = false
                    }
                } onError: { error in
                    DispatchQueue.main.async {
                        switch(error){
                            
                        case .ServerError:
                            self.errorMessage = "Server unreachable"
                        case .DataUnavailable:
                            self.errorMessage = "Error while ferching data"
                        case .ParsingError:
                            self.errorMessage = "Unable to parse the data"
                        }
                        self.isLoading = false
                    }
                }
            }else{
                self.isLoading = false
            }
            
        } onError: { Void in
            DispatchQueue.main.async {
                self.useCache = false
                self.isLoading = false
            }
        }
    }
    
    override func setMockEnvo(mockEnvo: NSManagedObjectContext) {
        self.mockEnvo = mockEnvo
        getStandingsUseCase.setMockEnvo(mockEnvo: mockEnvo)
    }
    
    override func handleEffect(effect: StandingsEffect) {
        
        switch(effect){
        case .GetStandings:
            self.isLoading = true
            getStandings()
        case .OnRefresh:
            if(useCache){
                mockEnvo?.refreshAllObjects()
            }else{
                getStandings()
            }
        }
    }
}
