//
//  TableViewModel.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class TableViewModel: NSObject, TableViewModelType {
    
    private var selectedIndexPath: IndexPath?
    private var news: [ShortNews]?
    
    private var storage: StorableContext
    
    @IBOutlet weak var networkManagerOfNews: NewsManager!
    
    private let DEFAULT_SET = 100
    private let DEFAULT_SIZE = 20
    
    var pageSize: Int
    var pageOffSet: Int
    
    func getNews(set: Int, size: Int, completion: (([ShortNews])->())?, errorHandle: ((NSError)->())?) {
        
        networkManagerOfNews.sendRequest(pageOffSet: set, pageSize: size)
        
        networkManagerOfNews.success = { [weak self] response in
            if let data = response {
                self?.pageOffSet += data.count
                
                self?.storage.fetchNews(objects: data, completion: { (news) in
                    completion?(news)
                })
            }
        }
        
        networkManagerOfNews.failure = { (error) in
            print("the error domain is \(error.domain)")
            print("the error code is \(error.code)")
            print("the error localizedDescription is \(error.localizedDescription)")
            errorHandle?(error)
        }
        
    }
    func fetchListOfNews(completion: @escaping()->()) {
        storage.fetchArticles(predicate: nil, sorted: [NSSortDescriptor(key: "createdTime", ascending: false)]) { [weak self](results) in
            guard let data = results else { return }
            let news = data.map{ ShortNews(fromCoreData: $0) }
            self?.news?.append(contentsOf: news)
        }
    }
    
    func loadToRefresh(completion: (()->())?, errorHandle: ((String)->())?) {
        self.pageOffSet = DEFAULT_SET
        getNews(set: pageOffSet, size: pageSize, completion: { [weak self] result in
            self?.news?.removeAll()
            self?.news?.append(contentsOf: result)
            completion?()
            }, errorHandle: { (error) in
                let errorInfo = (error.domain, error.code)
                switch errorInfo {
                //TODO: Lобавить больше типов для обработки ошибок
                case (NSURLErrorDomain, NSURLErrorNotConnectedToInternet):
                    errorHandle?("Подключение к Интернет отсутствует. Невозможно обновить новости")
                case (NSURLErrorDomain, NSURLErrorTimedOut):
                    errorHandle?("Время выполнения запросы на обновление новостей истекло")
                default:
                    errorHandle?("Ошибка выполнения запроса на сервере. Попробуйте позже.")
                }
        })
    }
    
    func numberOfRowsInSection() -> Int {
        return news?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        guard let news = news else { return nil }
        let shortNews = news[indexPath.row]
        return TableViewCellViewModel(news: shortNews)
    }
    
    func viewModelForSelectedRow() -> DetailedNewsViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        //TODO: I'm not sure
        return DetailedNewsViewModel(news: news![selectedIndexPath.row])
    }
    
    func pagingNews(atIndexPath indexPath: IndexPath, startAnimation: @escaping()->(), completion: (()->())?, errorHandle: ((String)->())?) {
        guard let news = news else { return }
        //TODO: Проверить логику на наличие кешированных данных, если pageOffSet = default тогда не делаем пагинацию иначе делаем
        guard pageOffSet != DEFAULT_SET else { return }
        if indexPath.row == news.count - 1 {
            startAnimation()
            getNews(set: pageOffSet, size: pageSize, completion:  { [weak self] result in
                self?.news?.append(contentsOf: result)
                completion?()
                }, errorHandle: { (error) in
                    let errorInfo = (error.domain, error.code)
                    switch errorInfo {
                    //TODO: Lобавить больше типов для обработки ошибок
                    case (NSURLErrorDomain, NSURLErrorNotConnectedToInternet):
                        errorHandle?("Подключение к Интернет отсутствует. Невозможно подгрузить новости.")
                    case (NSURLErrorDomain, NSURLErrorTimedOut):
                        errorHandle?("Время выполнения запроса подгрузки новостей истекло")
                    default:
                        errorHandle?("Ошибка выполнения запроса на сервере. Попробуйте позже.")
                    }
            })
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    override init() {
        self.storage = CoreDataStorageContext()
        self.pageSize = DEFAULT_SIZE
        self.pageOffSet = DEFAULT_SET
        self.news = [ShortNews]()
    }
    
}
