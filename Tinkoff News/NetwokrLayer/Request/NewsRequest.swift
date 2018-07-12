//
//  NewsRequest.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

struct NewsRequest: BackedAPIRequest {
    
    private var pageOffSet: Int
    private var pageSize: Int
    
    init(pageSize: Int, pageOffSet: Int) {
        self.pageSize = pageSize
        self.pageOffSet = pageOffSet
    }
    
    var endPoint: String {
        return "getArticles"
    }
    
    var method: MethodRequest {
        return .get
    }
    
    var query: Query {
        return .path
    }
    
    var parameters: [String : String]? {
        var params = [String: String]()
        params["pageOffset"] = String(describing: pageSize)
        params["pageSize"] = String(describing: pageSize)
        return params
    }
    
    var headers: [String : String]? {
        return defaultJSONHeaders()
    }
    

    
}
