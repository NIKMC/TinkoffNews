//
//  ArticleManager.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 12/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class ArticleManager {
    
//    private var request: NewsRequest?
    private var service: BackendService
    public var success: ((FullNewsJson)->())?
    public var failure: ((NSError)->())?
    
    init() {
        service = NetworkManagerBackendService(BackendConfiguration.shared)
    }
    
    func sendRequest(urlSlug url: String) {
        let request = ArticleRequest(urlSlug: url)
        self.service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: Data) {
        print("The data of getArticle: \(String(describing: response))")
        do {
            let data = try JSONDecoder().decode(Response.self, from: response)
            print("The response is: \(String(describing: data.response))")
            success?(data.response)
        } catch let error {
            print("Error of parsing \(error)")
            
        }
    }
    
    private func handleFailure(_ error: NSError) {
        self.failure?(error)
    }
    
}
