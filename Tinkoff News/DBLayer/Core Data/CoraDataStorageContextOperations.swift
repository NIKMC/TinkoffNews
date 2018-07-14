//
//  CoraDataStorageContextOperations.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation
import CoreData
//MARK: Extensions to add and update data in CoreData

extension CoreDataStorageContext {
    func add(object: Storable) {
        if let obj = (object) as? FullNewsJson {
            addNews(object: obj)
        }
        self.saveData()
    }
    
    func addNews(object: FullNewsJson){
        let news = News(context: self.context)
        news.id = object.id
        news.title = object.title
        news.createdTime = object.createdTime
        news.updatedTime = object.updatedTime
        news.urlSlug = object.slug
        news.counter = 1
        
    }
    
    
    
    func update(object: Storable) {
        if let obj = (object) as? News {
            updateNews(object: obj)
        }
        self.saveData()
    }
    
    func updateNews(object: News) {
        object.counter = object.counter + 1
        self.saveData()
    }
    
    
}

//MARK: Extensions to delete of data in CoreData

extension CoreDataStorageContext {
    
    func delete(object: Storable) {
        
    }
    
}

//MARK: Extensions to fetch of data in CoreData
extension CoreDataStorageContext {
    
    func fetchArticles(predicate: NSPredicate?, sorted: [NSSortDescriptor]?, completion: (([News]?) -> ())) {
        let request: NSFetchRequest<News> = News.fetchRequest()
        if predicate != nil {
            request.predicate = predicate
        }
        if sorted != nil {
            request.sortDescriptors = sorted
        }
        do {
            let listOfNews = try self.context.fetch(request)
            completion(listOfNews)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }
    
    func fetchNews(objects: [ShortNewsJson], completion: (([ShortNews]) -> ())) {
        var news = [ShortNews]()
        for object in objects {
            let value = try? News.findCounter(matching: object.id, in: self.context)
            if let counter = value {
                news.append(ShortNews(fromJson: object, with: counter))
            }
        }
        completion(news)
    }
    
    func fetch(object: FullNewsJson, completion: ((News)->())) {
        let news = try? News.findUpdateOrCreateNews(matching: object, in: context)
        if let news = news {
            self.saveData()
            completion(news)
        }
    }
    
   
}
