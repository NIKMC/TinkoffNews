//
//  BackedAPIRequest.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

public protocol BackedAPIRequest {
    var endPoint: String { get }
    var method: MethodRequest { get }
    var query: Query { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

extension BackedAPIRequest {
    func defaultJSONHeaders() ->[String: String] {
        return ["Content-Type": "application/json"]
    }
}
