//
//  UefaViewModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation

class UefaStandingsViewModel : ViewModel<UefaStandingsEffect>{
    
    @Published var isLoading:Bool = false
    @Published var uefaStandings:[String:[UefaStandingsUIModel]] = [:]
    @Published var uefaStandingsGroups = Array<String>()
    @Published var headerTitle = "UEFA Champions League"
    
    @Inject private var getUefaStandingsUseCase:GetUefaStandingsUseCase
    @Inject private var getUefaCacheCanBeUsed:GetUefaStandingsCanBeUsed
    @Inject private var getLocalUefaStandingsUseCase:GetLocalUefaStandingsUseCase
    
    override func handleEffect(effect: UefaStandingsEffect) {
        switch(effect){
            
        case .GetStandings:
            Task{
               await getUefaStandings()
            }
        case .OnRefresh:
            Task{
                await refreshStandings()
            }
            break;
        }
    }
    
    private func getUefaStandings() async{
        
        onUI {
            self.isLoading = true
        }
        
        let uefaCacheCanBeUsed = await getUefaCacheCanBeUsed.execute(argument: nil)

        if(Connectivity.isConnectedToInternet){
            
            if(uefaCacheCanBeUsed){
                await getLocalUefaStandings()
            }else{
                await getUefaStandingsFromServer()
            }
            
        }else{
            await getLocalUefaStandings()
        }
    }
    
    private func getLocalUefaStandings() async{
        let standings =  await getLocalUefaStandingsUseCase.execute(argument: nil).asUefaStandingsUIModel()
        
        onUI {
            self.uefaStandingsGroups = standings.keys.sorted(by: <)
            self.uefaStandings = standings
            
            self.isLoading = false
        }
    }
    
    private func getUefaStandingsFromServer() async{
        let standings =  await getUefaStandingsUseCase.execute(argument: nil).asUefaStandingsUIModel()
        
        onUI {
            self.uefaStandingsGroups = standings.keys.sorted(by: <)
            self.uefaStandings = standings
            
            self.isLoading = false
        }
    }
    
    func sortStandings(standings:[UefaStandingsUIModel]) -> [UefaStandingsUIModel]{
        return standings.sorted { $1.position.codingKey.intValue ?? 0 > $0.position.codingKey.intValue ?? 0}
    }
    
    private func refreshStandings() async{
        
        onUI {
            self.isLoading = true
        }
        
        let useCache = await getUefaCacheCanBeUsed.execute(argument: nil)
        
        if(useCache){
            await getLocalUefaStandings()
            onUI {
                self.isLoading = false
            }
        }else{
            onUI {
                self.uefaStandings = [:]
            }
            await getUefaStandingsFromServer()
        }
    }
}
