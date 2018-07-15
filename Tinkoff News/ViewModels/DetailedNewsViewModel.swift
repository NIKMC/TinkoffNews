//
//  DetailedNewsViewModel.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class DetailedNewsViewModel: DetailedNewsViewModelType {
    
    private var networkManagerOfArticle: ArticleManager
    
    private var storage: StorableContext
    
    var title: String {
        return news.title
    }
    
    var delegate: UpdateProtocol
    
    private var news: ShortNews
    
    var titleBox: Box<String?> = Box(nil)
    var textBox: Box<String?> = Box(nil)
    var publishedDateBox: Box<String?> = Box(nil)
    
    init(news: ShortNews, delegate: UpdateProtocol) {
        self.storage = CoreDataStorageContext()
        self.networkManagerOfArticle = ArticleManager()
        self.news = news
        self.delegate = delegate
    }
    
    func performLoad(completion: @escaping (News)->()) {
        fetchArticle(toUrlSlag: self.news.slug) { (result) in
            print("fetchArticle completion \(result.createdTime!)")
            completion(result)
        }
    }
    
    func performUpdate(completion: ((News)->())?, errorHandle: ((String)->())?) {
        getArticle(urlSlug: self.news.slug, completion: { [weak self] (result) in
            print("performUpdate update delegate")
            self?.delegate.updateCounterForCell()
            completion?(result)
        }, errorHandle: { (error) in
            let errorInfo = (error.domain, error.code)
            switch errorInfo {
            //TODO: Lобавить больше типов для обработки ошибок
            case (NSURLErrorDomain, NSURLErrorNotConnectedToInternet):
                errorHandle?("Подключение к Интернет отсутствует")
            case (NSURLErrorDomain, NSURLErrorTimedOut):
                errorHandle?("Время выполнения запросы истекло")
            default:
                errorHandle?("Ошибка выполнения запроса на сервере. Попробуйте позже.")
            }
        })
    }
    
    func getArticle(urlSlug url: String, completion: ((News) -> ())?, errorHandle: ((NSError)->())?) {
        networkManagerOfArticle.sendRequest(urlSlug: url)
        
        networkManagerOfArticle.success = { [weak self] result in
            self?.storage.fetch(object: result, completion: { (news) in
                completion?(news)
            })
        }
        
        networkManagerOfArticle.failure = { (error) in
            print("the error domain is \(error.domain)")
            print("the error code is \(error.code)")
            print("the error localizedDescription is \(error.localizedDescription)")
            errorHandle?(error)
        }
    }
    
    func fetchArticle(toUrlSlag urlSlug: String, completion: @escaping (News) -> ()) {
        storage.fetchArticles(predicate: NSPredicate(format: "urlSlug = %@", urlSlug), sorted: nil) { (articles) in
            guard let article = articles?.first else { return }
            completion(article)
        }
    }
    
    
}
