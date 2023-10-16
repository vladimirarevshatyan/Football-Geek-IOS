//
//  ViewModel.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/12/23.
//

import Foundation
import SwiftUI


class ViewModel<Effect:UIEffect> : ObservableObject{
    
    func handleEffect(effect:Effect){}
    
    func setEffect(effect:Effect){
        handleEffect(effect: effect)
    }
}
