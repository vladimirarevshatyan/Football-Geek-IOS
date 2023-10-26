//
//  CommonUI.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import SwiftUI

struct HeaderContent : View{
    
    let imageName:String
    let titleText:String
    
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .padding(.leading,20)
                
                Text(titleText)
                    .padding(.leading,20)
                    .font(.title2)
                    .foregroundStyle(.white)
                Spacer()
                
            }.frame(maxWidth:.infinity,maxHeight: 100,alignment: .leading)
        }.background(Color.darkBlue)
    }
}
