//
//  ViewModelsExtension.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/26/23.
//

import Foundation


extension ViewModel{
    
    func onUI(caller:@escaping ()->Void){
        DispatchQueue.main.async {
            caller()
        }
    }
}
