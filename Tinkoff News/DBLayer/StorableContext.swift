//
//  StorableContext.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

protocol StorableContext {
    
    //MARK: Save an object
    func add(object: Storable)
    
    //MARK: Update an object
    func update(object: Storable)
    
    //MARK: delete an object
    func delete(object: Storable)
    
    //MARK: fetch an objects
    
    func fetchArticles(predicate: NSPredicate?, sorted: [NSSortDescriptor]?, completion: (([News]?) -> ()))
    
//    func fetchNews(predicate: NSPredicate?, sorted: NSSortDescriptor?, completion: (([News?]) -> ()))
    
    func findAndUpdateNews(urlSlug: String) -> News?
    
    func fetch(object: FullNewsJson, completion: ((News)->()))
}
