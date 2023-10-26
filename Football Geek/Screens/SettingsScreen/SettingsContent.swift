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
    @State private var cancelable:AnyCancellable?
    
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
                
                HStack{
                    
                    Image(systemName: "opticaldiscdrive.fill")
                    
                    Text("Use Cace for Standings")
                        .font(.headline)
                        .padding(.leading,10)
                    
                    Spacer()
                    
                    Toggle("", isOn: $isCachenOn)
                        .labelsHidden()
                        .onChange(of: isCachenOn,initial: false) { oldState, newState in
                            viewModel.setEffect(effect: SettingsEffect.OnCacheToggleStateChange(value: isCachenOn))
                        }
                }
                
                HStack{
                    Image(systemName: "opticaldiscdrive.fill")
                    
                    Text("Standings Cache Time")
                        .font(.headline)
                        .padding(.leading,10)
                    
                    Spacer()
                    
                    DropDownMenu(labelText: viewModel.selectedCacheTimeText ?? "Choose Time", labelImage:nil, items: dropDownItems){item in
                        viewModel.setEffect(effect: SettingsEffect.OnStandingsCacheTimeSelected(id: item.id))
                    }
                }.padding(.top,30)
                
            }.onAppear{
                cancelable = viewModel.$isCacheOn.sink { value in
                    isCachenOn = value
                }
                viewModel.setEffect(effect: SettingsEffect.GetCacheToggleState)
                viewModel.setEffect(effect: SettingsEffect.GetUITexts)
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        }
    }
}

#Preview {
    SettingsContent()
}
