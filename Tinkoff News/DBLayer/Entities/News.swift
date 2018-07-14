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
    
    class func findUpdateOrCreateNews(matching newsInfo: FullNewsJson, in context: NSManagedObjectContext) throws -> News {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", newsInfo.id)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                matches[0].title = newsInfo.title
                matches[0].text = newsInfo.text
                matches[0].createdTime = newsInfo.createdTime
                matches[0].updatedTime = newsInfo.updatedTime
                matches[0].counter = matches[0].counter + 1
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
    
    class func findCounter(matching urlSlag: String, in context: NSManagedObjectContext) throws -> Int {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", urlSlag)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                return Int(matches[0].counter)
            }
        } catch {
            print("error of fetching request \(error.localizedDescription)")
            throw error
        }
        return 0
    }
}
