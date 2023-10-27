//
//  DIExtensions.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/24/23.
//

import Foundation
import SwiftUI


extension App {
    
    func module<FileType>(moduleType:ModuleType,moduleCall: @escaping ()->FileType
    ){
        
        switch(moduleType){
        case .Single:
            DIManager.registger(type: FileType.self, item: moduleCall);
        case .Factory:
            //For now factory is not implemented
            DIManager.registger(type:FileType.self,item: moduleCall);
        }
    }
}

extension Module{
    
    func module<FileType>(moduleType:ModuleType,moduleCall: @escaping ()->FileType
    ){
        
        switch(moduleType){
        case .Single:
            DIManager.registger(type: FileType.self, item: moduleCall);
        case .Factory:
            //For now factory is not implemented
            DIManager.registger(type:FileType.self,item: moduleCall);
        }
    }
}
