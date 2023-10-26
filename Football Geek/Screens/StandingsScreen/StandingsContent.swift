//
//  StandingsScreen.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import SwiftUI
import Combine
import CoreData

struct StandingsContent: View {
    @Environment(\.managedObjectContext) var mockEnvo
    @State private var cancelable:AnyCancellable?
    @State private var useCache:Bool = false
    @FetchRequest (sortDescriptors: [SortDescriptor(\.position)]) var localStandings:FetchedResults<StandingsUIDao>
    
    @ObservedObject
    private var viewModel:StandingScreenViewModel = StandingScreenViewModel()
    
    var body: some View {
        ZStack{
            if(viewModel.isLoading){
                LoadingContent()
                
            }
            
            if(viewModel.errorMessage != nil){
                ErrorContent(
                    errorMessage: viewModel.errorMessage
                )
            }
            
            if(useCache){
                SuccessContent(localStandings:localStandings, serverStandings:[],useCache: true){
                    viewModel.setEffect(effect: StandingsEffect.OnRefresh)
                }
                
            }else if(!viewModel.standingsUiModel.isEmpty){
                SuccessContent(localStandings: localStandings, serverStandings: viewModel.standingsUiModel,useCache: false){
                    viewModel.setEffect(effect: StandingsEffect.OnRefresh)
                }
            }
        }.task {
            cancelable = viewModel.$useCache.sink{ useCache in
                self.useCache = useCache
            }
            viewModel.setMockEnvo(mockEnvo: mockEnvo)
            viewModel.setEffect(effect: StandingsEffect.GetStandings)
        }
    }
}

private struct SuccessContent : View{
    let localStandings:FetchedResults<StandingsUIDao>
    let serverStandings:[StandingsUIModel]
    let useCache:Bool
    let onRefresh:()->Void
    
    var body : some View{
        VStack{
            
            HeaderContent(
                imageName: "figure.soccer",
                titleText:"Premier League Standings"
            )
            
            ScrollView{
                VStack(alignment:.leading){
                    if(useCache){
                        LocalStandings(localStandings: localStandings)
                    }else{
                        ServerStandings(standingsUiModel: serverStandings)
                    }
                }
                .padding(.leading,20)
                .padding(.trailing,20)
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
            }
            .refreshable {
                onRefresh()
            }
            .padding(.all,1)
        }
    }
}

private func LocalItemsFirstPart(model:StandingsUIDao)->some View{
    return HStack{VStack{
        Image(systemName: "soccerball.circle")
            .foregroundColor(Color.blue)
        Text(model.points ?? "")
            .font(.body)
    }
        
        VStack{
            Image(systemName: "figure.australian.football")
                .foregroundColor(Color.blue)
            Text(model.matches ?? "")
                .font(.body)
        }
        
        VStack{
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Color.green)
            Text(model.win ?? "")
                .font(.body)
        }
    }
}

private func LocalItemsSecondPart(model:StandingsUIDao)->some View{
    return HStack{ VStack{
        Image(systemName: "hand.raised.fill")
            .foregroundColor(Color.gray)
        Text(model.draw ?? "")
            .font(.body)
    }
        
        VStack{
            Image(systemName: "slash.circle.fill")
                .foregroundColor(Color.red)
            Text(model.lose ?? "")
                .font(.callout)
        }
    }
}

private func LocalStandings(localStandings:FetchedResults<StandingsUIDao>)-> some View{
    return ForEach(localStandings,id:\.id) { model in
        HStack{
            Text((model.position ?? "")+". "+(model.name?.replacingOccurrences(of: "&amp;", with: "&") ?? ""))
                .font(.headline)
            
            Spacer()
            
            LocalItemsFirstPart(model: model)
            LocalItemsSecondPart(model: model)
        }
        Divider()
    }
}

private func ServerStandings(standingsUiModel:[StandingsUIModel])->some View{
    
    return ForEach(standingsUiModel,id:\.id) { model in
        HStack{
            Text(model.position+". "+model.name.replacingOccurrences(of: "&amp;", with: "&"))
                .font(.headline)
            
            Spacer()
            
            HStack{
                
                VStack{
                    Image(systemName: "soccerball.circle")
                        .foregroundColor(Color.blue)
                    Text(model.points)
                        .font(.body)
                }
                
                VStack{
                    Image(systemName: "figure.australian.football")
                        .foregroundColor(Color.blue)
                    Text(model.matches)
                        .font(.body)
                }
                
                VStack{
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.green)
                    Text(model.win)
                        .font(.body)
                }
                
                VStack{
                    Image(systemName: "hand.raised.fill")
                        .foregroundColor(Color.gray)
                    Text(model.draw)
                        .font(.body)
                }
                
                VStack{
                    Image(systemName: "slash.circle.fill")
                        .foregroundColor(Color.red)
                    Text(model.lose)
                        .font(.callout)
                }
            }
        }
        Divider()
    }
}

private struct ErrorContent : View{
    
    let errorMessage:String?
    
    var body : some View{
        VStack(alignment:.leading){
            Text(errorMessage ?? "Unprocessable Error")
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
        }
        .padding(20)
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
    }
}

private struct LoadingContent : View{
    var body : some View{
        VStack(alignment:.leading){
            ProgressView()
                .frame(maxWidth:.infinity,
                       maxHeight: .infinity,alignment: .center)
        }
        .padding(20)
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
    }
}

#Preview {
    StandingsContent()
}
