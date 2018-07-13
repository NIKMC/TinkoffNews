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
    
    class func findOrCreateNews(matching newsInfo: FullNewsJson, in context: NSManagedObjectContext) throws -> News {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "urlSlug = %@", newsInfo.slug)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                matches[0].counter = matches[0].counter + 1
//                do {
//                    try context.save()
//                } catch {
//                    print("Error saving context \(error)")
//                }
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let news = News(context: context)
        news.id = newsInfo.id
        news.title = newsInfo.title
        news.text = newsInfo.text
        news.urlSlug = newsInfo.slug
        news.createdTime = newsInfo.createdTime
        news.updatedTime = newsInfo.updatedTime
        return news
    }
}
