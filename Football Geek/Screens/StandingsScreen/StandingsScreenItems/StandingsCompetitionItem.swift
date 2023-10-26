//
//  StandingsCompetitionItem.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/26/23.
//

import Foundation
import SwiftUI


func CompetitionContent(
    competitions:[CompetitionUIModel],
    chosenCompetitionName:String,
    onCompetitionClick:@escaping (_ competitionId:String,_ competitionName:String)->Void
)-> some View{
    
    return HStack{
        Text("Currently Viewing")
            .foregroundStyle(.gray)
        
        Spacer()
        
        let dropDownMenuItems = competitions.map { competitionUIModel in
            DropDownMenuItem(id: competitionUIModel.id, title: competitionUIModel.competitionName, image: nil)
        }
        
        DropDownMenu(labelText: chosenCompetitionName, labelImage: "flag.2.crossed.fill", items: dropDownMenuItems){ item in
            onCompetitionClick(item.id,item.title)
        }
    }
    .padding(.all,20)
}
