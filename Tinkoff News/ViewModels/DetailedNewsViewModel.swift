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
    
//    var fullNews: News?
    private var storage: StorableContext
    private var news: News?
    private var urlSlug: String {
        didSet {
            
        }
    }
    
    var title: Box<String?> = Box(nil)
    
    var date: Box<String?> = Box(nil)
    
    var text: Box<String?> = Box(nil)
    
    init(urlSlug: String) {
        self.storage = CoreDataStorageContext()
        self.networkManagerOfArticle = ArticleManager()
        self.urlSlug = urlSlug
        
    }
    
    func performUpdate(completion: @escaping (News)->()) {
        print("performUpdate")
        getArticle(urlSlug: self.urlSlug) { (result) in
            completion(result)
        }
    }
    
    func getArticle(urlSlug url: String, completion: @escaping (News) -> ()) {
        print("URLSLUG IS \(url)")
        print("fetchArticle")
        
        fetchArticle(toUrlSlag: self.urlSlug) { (result) in
            print("fetchArticle completion \(result.title!)")
            completion(result)
        }
        print("networkManagerOfArticle.sendRequest")
        
        networkManagerOfArticle.sendRequest(urlSlug: url)
        
        networkManagerOfArticle.success = { [weak self] result in
            print("networkManagerOfArticle.success")
            self?.storage.fetch(object: result, completion: { (news) in
                print("storage.fetch completion \(news.title!)")
                completion(news)
            })
        }
    }
    
    func fetchArticle(toUrlSlag urlSlug: String, completion: @escaping (News) -> ()) {
        storage.fetchArticles(predicate: NSPredicate(format: "urlSlug = %@", urlSlug), sorted: nil) { (articles) in
            guard let article = articles?.first else { return }
            completion(article)
        }
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


