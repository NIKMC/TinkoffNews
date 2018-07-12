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
    
    func getNews(set: Int, size: Int, completion: @escaping ([ShortNews])->()) {
        networkManagerOfNews.sendRequest(pageOffSet: set, pageSize: size)
        
        networkManagerOfNews.success = { [weak self] response in
            if let data = response {
                self?.pageOffSet += data.count
                // TODO: Скорее всего результат из сети проверять на наличие в СoreData а затем вставлять
                
                let news = data.map{ ShortNews(fromJson: $0) }
                completion(news)
            }
            
        }
    }
    func fetchListOfNews() {
        
    }
    
    func pullToRefresh(completion: @escaping ()->()) {
        self.pageOffSet = DEFAULT_SET
        news?.removeAll()
        getNews(set: pageOffSet, size: pageSize) { [weak self] result in
            self?.news = result
            completion()
        }
        
    }
    
    func numberOfRowsInSection() -> Int {
        return news?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        guard let news = news else { return nil}
        let shortNews = news[indexPath.row]
        return TableViewCellViewModel(news: shortNews)
    }
    
    func viewModelForSelectedRow() -> DetailedNewsViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        //TODO: I'm not sure
        return DetailedNewsViewModel(urlSlug: news![selectedIndexPath.row].slug, storableContext: storage)
    }
    
    func pagingNews(atIndexPath indexPath: IndexPath, startAnimation: @escaping()->(), completion: @escaping ()->()) {
        guard let news = news else { return }
        if indexPath.row == news.count - 1 {
            startAnimation()
            getNews(set: pageOffSet, size: pageSize) { [weak self] result in
                self?.news?.append(contentsOf: result)
                completion()
            }
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
//    func fetchNews() {
//        let sortDescriptor = NSSortDescriptor
//        storage.fetch(object: News.self, predicate: <#T##NSPredicate?#>, sorted: <#T##NSSortDescriptor?#>, completion: <#T##(([News]) -> ())##(([News]) -> ())##([News]) -> ()#>)
//    }
    
    override init() {
        self.storage = CoreDataStorageContext()
        self.pageSize = DEFAULT_SIZE
        self.pageOffSet = DEFAULT_SET
    }
    
}
