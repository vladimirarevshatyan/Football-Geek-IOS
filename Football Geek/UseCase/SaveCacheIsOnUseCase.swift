//
//  SaveCacheIsOnUseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation


class SaveCacheIsOnUseCase : ArgumentedUseCase{
    
    typealias ReturnType = Void
    
    typealias ArgumentType = Bool
    
    
    @Inject
    private var localRepoHelper:KeyValueStorage
    
    func execute(argument: Bool, result: () -> Void) async {
        localRepoHelper.setCacheIsOn(value: argument)
        result()
    }
    
}
