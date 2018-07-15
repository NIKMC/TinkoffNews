//
//  NetworkService.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

/// REST Method
///
/// - get: GET
/// - post: POST
/// - put: PUT
/// - delete: DELETE
public enum MethodRequest: String {
    case get, post, put, delete
}

public enum Query: String {
    case json, path
}


public typealias Parameters = [String: String]

class NetworkService {
    
    private var task:URLSessionDataTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499
    
    func makeRequest(for url: URL,
                     method: MethodRequest,
                     query type: Query,
                     params: [String: String]?,
                     headers: [String: String]?,
                     success: ((Data?)->())?,
                     failure: ((_ data: Data?, _ error: NSError?, _ responseCode:Int) -> ())?){
      
        
        var mutableRequest = NetworkQueryGenerator().makeQuery(for: url, params: params, type: type)
        mutableRequest.httpMethod = method.rawValue
        mutableRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        task = session.dataTask(with: mutableRequest, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error as NSError?, 0)
                return
            }
            
            if let error = error {
                failure?(data, error as NSError, httpResponse.statusCode)
                return
            }
            if self.successCodes.contains(httpResponse.statusCode){
                print("request's been finished with success \(String(describing: mutableRequest.url?.absoluteString))")
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode){
                print("request's been finished with failure")
                failure?(data,error as NSError?, httpResponse.statusCode)
            } else {
                print("Request finished with failure on the server.")
                failure?(data, error as NSError?, httpResponse.statusCode)
            }
        })
        
        task?.resume()
        
        
    }
    
    func cancel() {
        task?.cancel()
    }
}
