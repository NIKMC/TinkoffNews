//
//  News.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import UIKit
import CoreData

class News: NSManagedObject {

//    class func findAndUpdate(matching urlSlug: String, in context: NSManagedObjectContext) throws -> News? {
//        let request: NSFetchRequest<News> = News.fetchRequest()
//        request.predicate = NSPredicate(format: "urlSlug = %@", urlSlug)
//        
//        do {
//            let matches = try context.fetch(request)
//            if matches.count > 0 {
//                matches.first?.counter = (matches.first?.counter)! + 1
//                do {
//                    try context.save()
//                } catch {
//                    print("Error saving context \(error)")
//                }
//                return matches.first
//            } else {
//                return nil
//            }
//        } catch {
//            throw error
//        }
//    }
}
