//
//  HomeContent.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import SwiftUI

struct HomeContent : View{
    
    var body: some View {
        TabView{
            
            StandingsContent()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Standings")
                }
            
            SettingsContent()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    HomeContent()
}
