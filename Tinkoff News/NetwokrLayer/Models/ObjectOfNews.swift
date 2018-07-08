//
//  ObjectOfNews.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

struct ObjectOfNews: Decodable {
    var response: ResponseNews
}

struct ResponseNews: Decodable {
    var news: [ShortNewsJson?]
}

// struct ShortNews: Decodable {
//    var id: String
//    var title: String
//    var slug: String
//
//}

struct ShortNewsJson: Decodable {
    var id: String
    var title: String
    var slug: String
    
}

class ShortNews {
    var counter: Int
    var id: String
    var title: String
    var slug: String

    init(fromJson obj: ShortNewsJson) {
        self.id = obj.id
        self.title = obj.title
        self.slug = obj.slug
        self.counter = 0
    }
    
    init(id: String, title: String, slug: String) {
        self.id = id
        self.title = title
        self.slug = slug
        self.counter = 0
    }
    
}
