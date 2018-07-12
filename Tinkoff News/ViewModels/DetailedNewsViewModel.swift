//
//  DetailedNewsViewModel.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class DetailedNewsViewModel: DetailedNewsViewModelType {
    
//    private var shortNews: ShortNews
    
    private var networkManagerOfArticle: ArticleManager
    
    var fullNews: FullNews?
    private var storage: StorableContext
    private var news: News?
    private var urlSlug: String {
        didSet {
            
        }
    }
    
    var title: Box<String?> = Box(nil)
    
    var date: Box<String?> = Box(nil)
    
    var text: Box<String?> = Box(nil)
    
    init(urlSlug: String, storableContext storage: StorableContext) {
        self.urlSlug = urlSlug
        self.storage = storage
        self.networkManagerOfArticle = ArticleManager()
    }
    
    func performUpdate(completion: @escaping (FullNews)->()) {
        getArticle(urlSlug: self.urlSlug) { (result) in
            completion(result)
        }
    }
    
    func getArticle(urlSlug url: String, completion: @escaping (FullNews) -> ()) {
        print("URLSLUG IS \(url)")
        networkManagerOfArticle.sendRequest(urlSlug: url)
        
        networkManagerOfArticle.success = { result in
//            self?.storage.add(object: result)
            let fullNews = FullNews(fromJson: result)
            completion(fullNews)
        }
        
        
    }
    
    func fetchArticle(toUrlSlag urlSlug: String, completion: @escaping (News) -> ()) {
        
    }
    
    func fetchNews() {
        
    }
    
    
    //MARK: parse string datetime to good datetime
    
    func parseDateTimeString(oddDateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: oddDateTime) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createDate = dateFormatterString.string(from: date)
        return createDate
        
    }
    
    //MARK: parse html text to common text
    
    func parseHtmlText(fromHtmlText text: String) -> String {
        let convertedText = text.htmlToString
        return convertedText
    }
    
}

extension Data {
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        return Data(utf8).htmlToAttributedString
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


