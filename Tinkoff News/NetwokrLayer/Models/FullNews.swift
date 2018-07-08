//
//  NewsJSON.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

struct Response : Decodable {
    var response: FullNews
}

struct FullNews: Decodable {
    var id: String
    var title: String
    var text: String
    var createdTime: String
    var updatedTime: String
    var slug: String
//    var image: String?
//    var lang: String?
//    var deleted: Bool
//    var hidden: Bool
//    var date: String?
//
//    var disclaimer: String?
    
}

