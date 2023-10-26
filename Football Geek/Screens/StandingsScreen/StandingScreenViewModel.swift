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
    
    @Inject private var persistenceController:PersistenceController
    @Inject private var getStandingsUseCase:GetStandingsUseCase
    @Inject private var getCanUseCache:GetCacheCanBeUsed
    @Inject private var getCompetitionUseCase:GetCompetitionsUseCase
    @Inject private var getLocalStandingsUseCase:GetLocalStandingsUseCase
    @Inject private var refreshLocalDataUseCase:RefreshLocalStandingsUseCase
    
    @Inject private var timeHelper:TimeHelper
    @Inject private var localRepoHelper:KeyValueStorage
    
    private var mockEnvo:NSManagedObjectContext?
    
    @Published var standingsUiModel:[StandingsUIModel] = []
    @Published var isLoading:Bool = false;
    @Published var errorMessage:String? = nil
    @Published var headerTitle:String  = "Loading"
    @Published var competitions:[CompetitionUIModel] = []
    
    private func getStandings() async{
        
        onUI {
            self.errorMessage = nil
            self.isLoading = true
        }
        
        let competitionId = self.localRepoHelper.getString(key: DefaultsKeys.chosenCompetitionId) ?? Competition.EnglishPremierLeague.rawValue
        
        let useCache = await getCanUseCache.execute(argument:competitionId)
        
        onUI {
            self.headerTitle = Competition(rawValue: competitionId)?.getCompetitionName() ?? Competition.EnglishPremierLeague.getCompetitionName()
        }
        
        if(useCache){
            await getLocalStandings(competitionId:competitionId)
        }else{
            await getStandingsFromServer(competitionId: competitionId)
        }
    }
    
    private func refreshStandings() async{
        let competitionId = localRepoHelper.getString(key: DefaultsKeys.chosenCompetitionId) ?? Competition.EnglishPremierLeague.rawValue
        
        let useCache = await getCanUseCache.execute(argument:competitionId)
        
        onUI {
            self.headerTitle = Competition(rawValue: competitionId)?.getCompetitionName() ?? Competition.EnglishPremierLeague.getCompetitionName()
        }
        
        if(useCache){
            await refreshLocalDataUseCase.execute(argument: nil)
            onUI {
                self.isLoading = false
            }
        }else{
            await getLocalStandings(competitionId:competitionId)
        }
    }
    
    private func saveChosenCompetition(competitionId:String,name:String) async{
        localRepoHelper.saveString(value: competitionId, key: DefaultsKeys.chosenCompetitionId)
        headerTitle = Competition(rawValue: competitionId)?.getCompetitionName() ?? Competition.EnglishPremierLeague.getCompetitionName()
        await getStandings()
    }
    
    private func getLocalStandings(competitionId:String) async{
        let localStandings =  await getLocalStandingsUseCase.execute(argument: competitionId)
        onUI {
            self.standingsUiModel = localStandings.asStandingsUIModel().sorted { $1.position.codingKey.intValue ?? 0 > $0.position.codingKey.intValue ?? 0}
            self.isLoading = false
        }
    }
    
    private func getStandingsFromServer(competitionId:String) async{
        
        let standigsTables = await getStandingsUseCase.execute(argument:Competition(rawValue: competitionId))
        
        if(standigsTables.isEmpty){
            onUI {
                self.errorMessage = "Error while ferching data"
            }
        }else{
            let finalStandings =  standigsTables.map { standingsModel in
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
            onUI {
                self.standingsUiModel = finalStandings.sorted { $1.position.codingKey.intValue ?? 0 > $0.position.codingKey.intValue ?? 0}
                self.isLoading = false
            }
        }
    }
    
    private func getCompetitions() async{
        
        let competitions  =  await getCompetitionUseCase.execute(argument: nil)
        
        let competitionUIModels = competitions.map { competitionModel in
            let competitionName = competitionModel.getCompetitionName()
            let competitionId = competitionModel.rawValue
            return CompetitionUIModel(id: competitionId, competitionName: competitionName)
        }
        
        onUI {
            self.competitions = competitionUIModels
        }
        
    }
    
    override func handleEffect(effect: StandingsEffect) {
        
        switch(effect){
            
        case .GetStandings:
            Task{
                await getStandings()
            }
            
        case .OnRefresh:
            Task {
                await refreshStandings()
            }
            
        case .GetCompetitions:
            Task {
                await getCompetitions()
            }
            
        case .OnCompetitionChosen(let competitionId,let name):
            Task {
                await saveChosenCompetition(competitionId:competitionId,name:name)
            }
        }
    }
}
