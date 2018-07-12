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
    var news: [ShortNewsJson]?
}

struct ShortNewsJson: Decodable {
    var id: String
    var title: String
    var slug: String
    
}

