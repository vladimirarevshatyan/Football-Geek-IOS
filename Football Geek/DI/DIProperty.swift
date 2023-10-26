//
//  DIProperty.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/24/23.
//

import Foundation
import SwiftUI

@propertyWrapper
struct Inject<FileType:AnyObject>{
    
    var service:FileType
    
    init(){
        guard let service = DIManager.resolve(itemKey:FileType.self) else {
            let serviceName = String(describing: FileType.self)
            fatalError("No service of type \(serviceName) registered!")
        }
        
        self.service = service 
    }
    
    var wrappedValue:FileType{
        get{
            return service
        }
    }
}

@propertyWrapper
struct InjectObservable<FileType:ObservableObject>{
    
    var service:FileType
    
    init(){
        guard let service = DIManager.resolve(itemKey:FileType.self) else {
            let serviceName = String(describing: FileType.self)
            fatalError("No service of type \(serviceName) registered!")
        }
        
        self.service = service
    }
    
    var wrappedValue:FileType{
        get{
            return service
        }
    }
}
