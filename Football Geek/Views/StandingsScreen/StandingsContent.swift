//
//  StandingsScreen.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import SwiftUI

struct StandingsContent: View {
    
    @StateObject private var viewModel:StandingScreenViewModel = StandingScreenViewModel(getStandingsUseCase: GetStandingsUseCase(standingsService: StandingsServiceImpl()))
    
    var body: some View {
        
        ZStack{
            if(viewModel.isLoading){
              LoadingContent()
            }
            
            if(viewModel.emptyResult){
                ErrorContent()
            }
            
            if(!viewModel.standingsUiModel.isEmpty){
                SuccessContent(standingsUiModel: viewModel.standingsUiModel)
            }
        }.onAppear{
            viewModel.setEffect(effect: StandingsEffect.GetStandings)
        }
    }
}

private struct SuccessContent : View{
    let standingsUiModel:[StandingsUIModel]
    
    var body : some View{
        ScrollView{
            VStack(alignment:.leading){
                ForEach(standingsUiModel,id:\.id) { model in
                    HStack{
                        Text(model.name+" -")
                            .padding(.bottom,10)
                            .padding(.top,20)
                        
                        Text(model.abbrevation)
                            .padding(.bottom,10)
                            .padding(.top,20)
                    }
                }
            }
            .padding(20)
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
        }
        .padding(.all,1)
    }
}

private struct ErrorContent : View{
    
    var body : some View{
        VStack(alignment:.leading){
            Text("No Result Found")
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
