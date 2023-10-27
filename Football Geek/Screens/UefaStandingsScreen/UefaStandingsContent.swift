//
//  UefaContent.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation
import SwiftUI


struct UefaStandingsContent : View {
    
    @ObservedObject private var viewModel = UefaStandingsViewModel()
    
    var body : some View{
        ZStack{
            
            if(viewModel.isLoading){
                LoadingContent()
            }
            
            if(!viewModel.uefaStandings.isEmpty){
                SuccessContent(
                    standingsGroupName: viewModel.uefaStandingsGroups,
                    standings: viewModel.uefaStandings,
                    sortStandings: { standings in
                        return viewModel.sortStandings(standings: standings ?? [])
                    },
                    onRefresh: {
                        viewModel.setEffect(effect: UefaStandingsEffect.OnRefresh)
                    }
                )
            }
            
        }.onAppear{
            viewModel.setEffect(effect: .GetStandings)
        }
    }
    
    private func SuccessContent(
        standingsGroupName:Array<String>,
        standings:[String:[UefaStandingsUIModel]],
        sortStandings:
        @escaping([UefaStandingsUIModel]?)->[UefaStandingsUIModel],
        onRefresh:@escaping ()->Void
    ) -> some View{
        return VStack{
            
            HeaderContent(
                imageName: "figure.soccer",
                titleText:viewModel.headerTitle
            )
            
            List {
                ForEach(standingsGroupName, id: \.self) { item in
                    Section(header: Text("Group: "+item)) {
                        let groupStandings = sortStandings(standings[item])
                        ForEach(groupStandings,id: \.self){standing in
                            StandingsTeamInfoContent(standing: standing)
                        }
                    }
                }
            }  
            .refreshable {
              onRefresh()
            }
        }
    }
    
    private func StandingsTeamInfoContent(standing:UefaStandingsUIModel)->some View{
        HStack{
            Text(standing.position)
            Text(standing.name)
            Spacer()
            
            VStack{
                Image(systemName: "soccerball.circle")
                    .foregroundColor(Color.blue)
                Text(standing.points)
                    .font(.body)
            }
            VStack{
                Image(systemName: "figure.australian.football")
                    .foregroundColor(Color.blue)
                Text(standing.gamesPlayed)
                    .font(.body)
            }
        }
    }
}

#Preview {
    UefaStandingsContent()
}
