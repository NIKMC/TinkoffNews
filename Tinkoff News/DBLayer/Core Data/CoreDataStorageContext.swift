//
//  CoreDataStorageContext.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStorageContext: StorableContext {
   
    var context : NSManagedObjectContext
    
    required init() {
        context = AppDelegate.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
