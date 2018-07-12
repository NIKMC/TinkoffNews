////
////  NetworkManager.swift
////  Tinkoff News
////
////  Created by Ivan Nikitin on 09/07/2018.
////  Copyright © 2018 Иван Никитин. All rights reserved.
////
//
//import Foundation
//
//class NetworkManager: NSObject, NetworkManagerType {
//    var urlBasic: String {
//        return "https://cfg.tinkoff.ru/news/public/api/platform/v1/"
//    }
//
//    func getArticles(substring: String, params: [String : String], completion: @escaping ([ShortNewsJson?]) -> ()) {
////    let params: [String:String] = ["pageOffset" : String(describing: pageOffset), "pageSize" : String(describing: pageSize)]
//
//        let urlComp = NSURLComponents(string: "\(urlBasic)getArticles")!
//
//        urlComp.queryItems = params.map { (key, value) in
//            URLQueryItem(name: key, value: value)
//        }
//
//        URLSession.shared.dataTask(with: urlComp.url!) { (data, response, error) in
//            guard let data = data else { return }
//            print("The data: \(data)")
//            print("The responce: \(String(describing: response))")
//            do {
//                let resp = try JSONDecoder().decode(ObjectOfNews.self, from: data)
//                print("The response is: \(String(describing: resp.response.news?.first))")
//                completion(resp.response.news!)
////                DispatchQueue.main.async {
////                    self.refreshControl?.endRefreshing()
////                }
//
//                //                self.tableView.reloadData()
//            } catch let error {
//                print("Error of parsing \(error)")
//            }
//            }.resume()
//    }
//
//    func getArticle(substring: String, params: [String : String], completion: @escaping (FullNewsJson) -> ()) {
//        let urlComp = NSURLComponents(string: "\(urlBasic)getArticle")!
//
//        urlComp.queryItems = params.map { (key, value) in
//            URLQueryItem(name: key, value: value)
//        }
//
//        URLSession.shared.dataTask(with: urlComp.url!) { [unowned self] (data, response, error) in
//            guard let data = data else { return }
//            print("The data: \(data)")
//            print("The responce: \(String(describing: response))")
//            do {
//                let resp = try JSONDecoder().decode(Response.self, from: data)
//                print("The response is: \(resp)")
//                completion(resp.response)
////                DispatchQueue.main.async {
////                    self.titleLabel.text = resp.response.title
////                    //                    self.dateTimeLabel.text = parseDateTimeString(oddDateTime: resp.response.createdTime)
////                    //                    self.textLabel = parseText(fromJsonText: resp.response.text)
////                    self.dateTimeLabel.text = resp.response.createdTime
////                    self.textLabel.text = resp.response.text
////                }
//
//            } catch let error {
//                print("Error of parsing \(error)")
//            }
//            }.resume()
//    }
//
//
//}
