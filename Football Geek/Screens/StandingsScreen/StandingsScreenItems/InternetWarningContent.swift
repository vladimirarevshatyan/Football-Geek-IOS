//
//  InternetWarningContent.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation
import SwiftUI

func InternetWarningContent(
    onClick:@escaping ()->Void
) -> some View{
    return HStack{
        Image(systemName: "info.circle.fill")
            .foregroundStyle(.blue)
        
        Text("No internet connection. Tap for more")
            .foregroundStyle(.gray)
        Spacer()
    }.onTapGesture {
        onClick()
    }
    .padding(.leading,20)
    .padding(.top,10)
}
