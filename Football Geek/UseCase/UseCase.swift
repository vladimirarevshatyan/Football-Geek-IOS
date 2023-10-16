//
//  UseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation

protocol UseCase{
    associatedtype ReturnType

    func execute(onSuccess: @escaping (ReturnType)->Void,onError:@escaping ()->Void)
}
