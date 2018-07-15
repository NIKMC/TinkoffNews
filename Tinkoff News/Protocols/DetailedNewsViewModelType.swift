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
    
    var delegate: UpdateProtocol { get }
    
    var titleBox: Box<String?> { get }
    var textBox: Box<String?> { get }
    var publishedDateBox: Box<String?> { get }
    
    func performLoad(completion: @escaping (News)->())
    
    func performUpdate(completion: ((News)->())?, errorHandle: ((String)->())?)
    
    func getArticle(urlSlug url: String, completion: ((News) -> ())?, errorHandle: ((NSError)->())?)
    
    func fetchArticle(toUrlSlag urlSlug: String, completion: @escaping (News)->())
    
    //    func parseHtmlText(fromHtmlText text: String) -> String
    //    
    //    func parseDateTimeString(oddDateTime: String) -> String
    
}
