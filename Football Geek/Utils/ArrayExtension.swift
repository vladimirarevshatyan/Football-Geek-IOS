//
//  ArrayExtension.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/27/23.
//

import Foundation


extension Array {
    
    func group<Discrimininator>(by discriminator: (Element)->(Discrimininator)) -> [Discrimininator: [Element]] where Discrimininator: Hashable {
        
        var result = [Discrimininator: [Element]]()
        for element in self {
            let key = discriminator(element)
            var array = result[key] ?? [Element]()
            array.append(element)
            result[key] = array
        }
        
        return result
    }
}
