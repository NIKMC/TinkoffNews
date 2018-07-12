//
//  ArticlesRequest.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

struct ArticleRequest: BackedAPIRequest {
    
    private var urlSlug: String
    
    init(urlSlug url: String) {
        self.urlSlug = url
    }
    
    var endPoint: String {
        return "getArticle"
    }
    
    var method: MethodRequest {
        return .get
    }
    
    var query: Query {
        return .path
    }
    
    var parameters: [String : String]? {
        var params = [String: String]()
        params["urlSlug"] = urlSlug
        return params
    }
    
    var headers: [String : String]? {
        return defaultJSONHeaders()
    }
}
