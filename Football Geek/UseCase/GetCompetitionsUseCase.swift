//
//  GetCompetitionsUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/26/23.
//

import Foundation
import CoreData

class GetCompetitionsUseCase : UseCase{
    
    typealias Argument = Void
    typealias ReturnType = [Competition]
    
    
    func execute(argument: Void?) async -> [Competition] {
        return Competition.allCases
    }
}
