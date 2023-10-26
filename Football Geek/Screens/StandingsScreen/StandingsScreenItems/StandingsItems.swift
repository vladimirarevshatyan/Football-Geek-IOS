//
//  StandingsContentItems.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/26/23.
//

import Foundation
import SwiftUI

 func StandingsItem(standingsUiModel:[StandingsUIModel])->some View{
    
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
