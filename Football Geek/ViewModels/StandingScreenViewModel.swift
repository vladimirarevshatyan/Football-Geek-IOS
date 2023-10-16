//
//  StandingScreenViewModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import Foundation

class StandingScreenViewModel : ViewModel<StandingsEffect>{
    
    init(getStandingsUseCase: GetStandingsUseCase) {
        self.getStandingsUseCase = getStandingsUseCase
    }
    
    private let getStandingsUseCase:GetStandingsUseCase
    
    @Published var standingsUiModel:[StandingsUIModel] = []
    @Published var isLoading:Bool = true;
    @Published var emptyResult:Bool = false
    
    private func getStandings(){
        
        getStandingsUseCase.execute { models in
            let finalStandings =  models.map { standingsModel in
                return StandingsUIModel(name: standingsModel.team.name,abbrevation: standingsModel.team.abbreviation)
             }
             
             DispatchQueue.main.async {
                 self.standingsUiModel = finalStandings
                 self.isLoading = false
             }
        } onError: {
            DispatchQueue.main.async {
                self.emptyResult = true
                self.isLoading = false
            }
        }
    }
    
    override func handleEffect(effect: StandingsEffect) {
        
        switch(effect){
            
        case .GetStandings:
            getStandings()
        }
    }
}
