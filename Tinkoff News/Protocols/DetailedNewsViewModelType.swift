//
//  DetailedNewsViewController.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

protocol DetailedNewsViewModelType {
    var title: String { get }
    var date: String { get }
    var text: String { get }
    
    func getArticle(toUrlSlug urlSlug: String, completion: @escaping (FullNews)->())
    
    func fetchArticle(toUrlSlag urlSlug: String, completion: @escaping (News)->())
    
    func parseHtmlText(fromHtmlText text: String) -> String
    
    func parseDateTimeString(oddDateTime: String) -> String
}
