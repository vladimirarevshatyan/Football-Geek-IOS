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

    func execute(argument:Argument?) async ->  ReturnType
}
