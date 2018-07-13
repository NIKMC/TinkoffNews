//
//  ArticlesManager.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 12/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class NewsManager: NSObject {
    
    //    private var request: NewsRequest?
    private var service: BackendService?
    public var success: (([ShortNewsJson]?)->())?
    public var failure: ((NSError)->())?
    
    
    func sendRequest(pageOffSet: Int, pageSize: Int) {
        self.service = NetworkManagerBackendService(BackendConfiguration.shared)
        let request = NewsRequest(pageSize: pageSize, pageOffSet: pageOffSet)
        self.service?.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: Data) {
//        print("The data of getArticles: \(String(describing: response))")
        do {
            let resp = try JSONDecoder().decode(ObjectOfNews.self, from: response)
//            print("The response is: \(String(describing: resp.response.news?.first))")
            success?(resp.response.news)
        } catch let error {
            print("Error of parsing \(error)")
            
        }
    }
    
    private func handleFailure(_ error: NSError) {
        self.failure?(error)
    }
    
}
