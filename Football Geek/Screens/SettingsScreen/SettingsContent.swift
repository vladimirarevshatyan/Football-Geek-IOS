//
//  SettingsContent.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import SwiftUI
import Combine


struct SettingsContent  : View{
    
    @State private var isCachenOn:Bool  = false
    @State private var isUefaCachenOn:Bool  = false
    @State private var cancelable:AnyCancellable?
    @State private var uefaCancelable:AnyCancellable?
    
    @ObservedObject private var viewModel:SettingsViewModel = SettingsViewModel()
    
    private let dropDownItems:[DropDownMenuItem] = [
        DropDownMenuItem(id: DropDownTimeModel.ThirtyMinutes, title: "30 minutes", image: "clock"),
        DropDownMenuItem(id: DropDownTimeModel.OneHour, title: "1 hour", image: "clock")
    ]
    
    var body : some View{
        VStack{
            
            HeaderContent(
                imageName: "gearshape.fill",
                titleText:"Settings"
            )
            
            VStack(alignment: .leading) {
                
                Text("Standings")
                    .font(.title3)
                
                Divider().frame(height: 1).background(.white)

                
                HStack{
                    Image(systemName: "opticaldiscdrive.fill")
                    
                    Text("Use Cace for Standings")
                        .font(.body)
                        .padding(.leading,10)
                    
                    Spacer()
                    
                    Toggle("", isOn: $isCachenOn)
                        .labelsHidden()
                        .onChange(of: isCachenOn,initial: false) { oldState, newState in
                            viewModel.setEffect(effect: SettingsEffect.OnStandingsToggleStateChange(value: isCachenOn))
                        }
                }.padding(.top,10)
                
                HStack{
                    Image(systemName: "calendar.badge.clock")
                    
                    Text("Standings Cache Time")
                        .font(.body)
                        .padding(.leading,10)
                    
                    Spacer()
                    
                    DropDownMenu(labelText: viewModel.selectedStandingsCacheTime ?? "Choose Time", labelImage:nil, items: dropDownItems){item in
                        viewModel.setEffect(effect: SettingsEffect.OnStandingsCacheTimeSelected(id: item.id))
                    }
                }.padding(.top,30)
                
            
                UefaCacheSettingsContent()
                    .padding(.top,40)
                
            }.onAppear{
                cancelable = viewModel.$isStandingsCacheOn.sink { value in
                    isCachenOn = value
                }
                
                uefaCancelable = viewModel.$isUefaStandingsCacheOn.sink { value in
                    isUefaCachenOn = value
                }
                
                viewModel.setEffect(effect: SettingsEffect.GetCacheToggleState)
                viewModel.setEffect(effect: SettingsEffect.GetUITexts)
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        }
    }
    
    private func UefaCacheSettingsContent()-> some View{
        
        return VStack(alignment: .leading){
            
            Text("UEFA")
                .font(.title3)
            
            Divider().frame(height: 1).background(.white)
            
            HStack{
                
                Image(systemName: "opticaldiscdrive.fill")
                
                Text("Use Cace for Standings")
                    .font(.body)
                    .padding(.leading,10)
                
                Spacer()
                
                Toggle("", isOn: $isUefaCachenOn)
                    .labelsHidden()
                    .onChange(of: isUefaCachenOn,initial: false) { oldState, newState in
                        viewModel.setEffect(effect: SettingsEffect.OnUefaStandingsToggleStateChange(value: isUefaCachenOn))
                    }
            }.padding(.top,10)
            
            HStack{
                Image(systemName: "calendar.badge.clock")
                
                Text("Standings Cache Time")
                    .font(.body)
                    .padding(.leading,10)
                
                Spacer()
                
                DropDownMenu(labelText: viewModel.selectedUefaCacheTime ?? "Choose Time", labelImage:nil, items: dropDownItems){item in
                    viewModel.setEffect(effect: SettingsEffect.OnUefaStandingsCacheTimeSelected(id: item.id))
                }
            }.padding(.top,30)
        }
    }
}

#Preview {
    SettingsContent()
}
