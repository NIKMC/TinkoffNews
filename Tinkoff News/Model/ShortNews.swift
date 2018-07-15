//
//  ShortNews.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class ShortNews {
    var counter: Int
    var id: String
    var title: String
    var slug: String
    
    init(fromJson obj: ShortNewsJson, with counter: Int) {
        self.id = obj.id
        self.title = obj.title
        self.slug = obj.slug
        self.counter = counter
    }
    
    init(fromCoreData obj: News) {
        self.id = obj.id!
        self.title = obj.title!
        self.slug = obj.urlSlug!
        self.counter = Int(obj.counter)
    }
}
