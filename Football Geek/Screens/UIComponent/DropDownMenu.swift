//
//  DropDownMenu.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/24/23.
//

import Foundation
import SwiftUI

func DropDownMenu(
    labelText:String,
    labelImage:String?,
    items:[DropDownMenuItem],
    onItemClick:@escaping (String)->Void
)-> some View{
    return Menu {
        
        ForEach(items){item in
            Button {
                onItemClick(item.id)
            } label: {
                Label(item.title, systemImage: item.image ?? "")
            }
        }
    } label: {
        Label(labelText, systemImage: labelImage ?? "")
    }
}

struct DropDownMenuItem : Identifiable{
    let id: String
    let title:String
    let image:String?
}

