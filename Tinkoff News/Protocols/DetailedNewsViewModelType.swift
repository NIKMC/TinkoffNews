//
//  DetailedNewsViewController.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

protocol DetailedNewsViewModelType {
    var title: Box<String?> { get }
    var date: Box<String?> { get }
    var text: Box<String?> { get }
    
    func performUpdate(completion: @escaping (FullNews)->())
    
    func getArticle(urlSlug url: String, completion: @escaping (FullNews)->())
    
    func fetchArticle(toUrlSlag urlSlug: String, completion: @escaping (News)->())
    
    func parseHtmlText(fromHtmlText text: String) -> String
    
    func parseDateTimeString(oddDateTime: String) -> String
    
    func fetchNews()
}
