//
//  NetworkManagerBackendService.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 12/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class NetworkManagerBackendService: BackendService {
    
    private let conf: BackendConfiguration
    private let service = NetworkService()
    
    init(_ conf: BackendConfiguration) {
        self.conf = conf
    }
    
    func request(_ request: BackedAPIRequest, success: ((Data) -> ())?, failure: ((NSError) -> ())?) {
        let url = conf.apiURL.appendingPathComponent(request.endPoint)
        
        service.makeRequest(for: url, method: request.method, query: request.query, params: request.parameters, headers: request.headers, success: { (data) in
            if let data = data {
                success?(data)
            }
        }) { (data, error, statusCode) in
            if data == nil {
                failure?(error ?? NSError(domain: "Error on backend side", code: 0, userInfo: nil))
            }
        }
    }
    
    func cancel() {
        self.service.cancel()
    }
    
    
}
