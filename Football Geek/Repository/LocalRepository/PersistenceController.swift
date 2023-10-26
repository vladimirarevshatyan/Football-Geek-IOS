//
//  PersistenceController.swift
//  Football Geek
//
//  Created by Vladimir Arevshatyan on 10/19/23.
//

import Foundation
import CoreData

class  PersistenceController {

    private static var persistentContainer: NSPersistentContainer = {
               let container = NSPersistentContainer(name: "LocalData")
               container.loadPersistentStores { description, error in
                   if let error = error {
                        fatalError("Unable to load persistent stores: \(error)")
                   }
               }
               return container
           }()
    
    var context: NSManagedObjectContext {
           return Self.persistentContainer.viewContext
       }
}
