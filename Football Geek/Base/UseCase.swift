//
//  UseCase.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/16/23.
//

import Foundation
import CoreData

protocol UseCase{
    associatedtype Argument
    associatedtype ReturnType
    associatedtype ErrorType

    func execute(argument:Argument?,onSuccess: @escaping (ReturnType)->Void,onError:@escaping (ErrorType)->Void)
}
