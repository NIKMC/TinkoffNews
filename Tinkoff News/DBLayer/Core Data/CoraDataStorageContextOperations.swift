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
    
//    func fetchNews(predicate: NSPredicate?, sorted: NSSortDescriptor?, completion: (([News]?) -> ())) {
//        
//        let request: NSFetchRequest<News> = News.fetchRequest()
//        if predicate != nil {
//            request.predicate = predicate
//        }
//        //TODO: Xто делать если количество закешированных данных >20 выгружать сразу все из кеша или делать подгрузку?
//        request.sortDescriptors = [NSSortDescriptor(key: "createdTime", ascending: false)]
//        do {
//            let matches = try self.context.fetch(request)
//            if matches.count > 0 {
//                completion(matches)
//            }
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    
    func findAndUpdateNews(urlSlug: String) -> News? {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "urlSlug = %@", urlSlug)
        do {
            let matches = try self.context.fetch(request)
            if matches.count > 0 {
                matches.first?.counter = (matches.first?.counter)! + 1
                self.saveData()
                return matches.first
            } else {
                return nil
            }
        } catch {
            print("Error of finding news by urlSlug \(error)")
            //            throw error
        }
        return nil
    }
    
    func fetch(object: FullNewsJson, completion: ((News)->())) {
        let news = try? News.findOrCreateNews(matching: object, in: context)
        if let news = news {
            self.saveData()
            completion(news)
        }
    }
    
    //    func fetch<T:Storable>(object: T, predicate: NSPredicate?, sorted: [NSSortDescriptor]?, completion: ((T?)->()?)) {
    //
    //        var request: NSFetchRequest<NSFetchRequestResult>?
    //        switch object {
    //        case is News:
    //            request = News.fetchRequest()
    //            let news = findAndUpdateNews(fromRequest: request as! NSFetchRequest<News>, predicate: predicate)
    //            completion(news as! T) //I don't have idea how to transfer and make function more general
    //        default:
    //            break
    //        }
    //    }
    
    
}
