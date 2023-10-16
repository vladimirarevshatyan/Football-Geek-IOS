//
//  StandingsScreen.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import SwiftUI

struct StandingsContent: View {
    
    @StateObject private var viewModel = StandingScreenViewModel()
    
    var body: some View {
        HStack{
            ForEach(viewModel.standingUIModels,id:\.id) { model in
                Spacer()
                Text(model.name)
            }
            
        }.scaledToFill()
    }
}

#Preview {
    StandingsContent()
}
