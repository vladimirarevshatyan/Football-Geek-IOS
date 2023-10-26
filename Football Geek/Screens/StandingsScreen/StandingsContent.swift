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
    @State private var showBottomSheet:Bool = false
    
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
            
            if(!viewModel.standingsUiModel.isEmpty){
                SuccessContent(viewModel: viewModel){
                    viewModel.setEffect(effect: StandingsEffect.OnRefresh)
                }
            }
            
        }.task {
            viewModel.setEffect(effect: StandingsEffect.GetCompetitions)
        }.onAppear{
            viewModel.setEffect(effect: StandingsEffect.GetStandings)
        }
    }
    
    private func SuccessContent (
        viewModel:StandingScreenViewModel,
        onRefresh:@escaping ()->Void
    )-> some View{
        
        return  VStack{
            
            HeaderContent(
                imageName: "figure.soccer",
                titleText:viewModel.headerTitle
            )
            
            if(viewModel.showInternetWarning){
                InternetWarningContent{
                    showBottomSheet.toggle()
                }
            }
            
            if(!viewModel.competitions.isEmpty){
                
                CompetitionContent(
                    competitions: viewModel.competitions, chosenCompetitionName: viewModel.headerTitle){ chosenCompetitionId,chosenCompetitionName in
                        viewModel.setEffect(effect: StandingsEffect.OnCompetitionChosen(id: chosenCompetitionId, name: chosenCompetitionName))
                    }
            }
            
            ScrollView{
                VStack(alignment:.leading){
                    StandingsItem(standingsUiModel: viewModel.standingsUiModel)
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
        .sheet(isPresented: $showBottomSheet){
            BottomSheet(
                title: "No Internet Connection",
                message: "You Don't have an active internet connection and we are currently using available local data where possible. Once internet connection is restored, we will update data", leftIcon:"exclamationmark.bubble.fill",
                iconTintColor: .blue
            )
            .presentationDetents([.medium])
        }
    }
    
    private func ErrorContent(errorMessage:String?) -> some View{
        
        return VStack(alignment:.leading){
            Text(errorMessage ?? "Unprocessable Error")
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
        }
        .padding(20)
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
    }
    
    private func LoadingContent ()-> some View{
        
        return VStack(alignment:.leading){
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
