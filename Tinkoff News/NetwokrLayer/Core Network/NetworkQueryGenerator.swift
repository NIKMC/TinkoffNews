//
//  NetworkQueryGenerator.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

struct NetworkQueryGenerator {
    func makeQuery(for url: URL, params: [String: String]?, type: Query) -> URLRequest {
        switch type {
        case .path:
            let urlComponent = NSURLComponents(string: url.absoluteString)!
            guard let params = params else { return URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)}

            urlComponent.queryItems = params.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            return URLRequest(url: urlComponent.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            
        default:
            return URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        }
    }
}
