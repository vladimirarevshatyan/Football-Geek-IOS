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

func BottomSheet(
    title:String,
    message:String,
    leftIcon:String,
    iconTintColor:Color = .gray
) -> some View{
    return VStack(alignment:.leading){
        HStack{
            Image(systemName: leftIcon)
                .resizable()
                .frame(width: 42.0, height: 42.0)
                .foregroundColor(iconTintColor)
                .padding(.leading,20)
                .padding(.top,30)
            
            Spacer()
            
            Text(title)
                .font(.title2)
                .lineLimit(1)
                .padding(.top,18)
            
            Spacer()
            Spacer()
            
        }.frame(maxWidth: .infinity, alignment: .topLeading)
        
        Text(message)
            .font(.body)
            .padding()
        
    }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
}

func LoadingContent ()-> some View{
    
    return VStack(alignment:.leading){
        ProgressView()
            .frame(maxWidth:.infinity,
                   maxHeight: .infinity,alignment: .center)
    }
    .padding(20)
    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
}

#Preview {
    StandingsContent()
}
