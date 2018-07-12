//
//  FullNews.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 12/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class FullNews {
    var id: String
    var title: String
    var slug: String
    var text: String
    var counter: Int
    var createdTime: String
    var updatedTime: String
    
    init(fromJson obj: FullNewsJson) {
        self.id = obj.id
        self.title = obj.title
        self.slug = obj.slug
        self.text = obj.text
        self.createdTime = obj.createdTime
        self.updatedTime = obj.updatedTime
        self.counter = 1
    }
    
    init(id: String, title: String, slug: String, text: String, createdTime: String, updatedTime: String) {
        self.id = id
        self.title = title
        self.slug = slug
        self.text = text
        self.createdTime = createdTime
        self.updatedTime = updatedTime
        self.counter = 1
    }
    
}
