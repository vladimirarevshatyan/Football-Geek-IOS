//
//  DIManager.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/24/23.
//

import Foundation
import SwiftUI

final class DIManager {
    
    private init(){}
    
    static var services:[String: () -> Any] = [:]
    
    static var observableServices:[String: () -> Any] = [:]
    
    static func registger<FileType>(type:FileType.Type,item: @escaping ()->FileType){
        let serviceName = String(describing: type.self)
        services[serviceName] = item
    }
    
    static func resolve<FileType>(itemKey:FileType.Type)->FileType?{
        let serviceName = String(describing: itemKey.self)
        return services[serviceName]?() as? FileType
    }
}

public enum ModuleType{
    case Single
    case Factory
}
