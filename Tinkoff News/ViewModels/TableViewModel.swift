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
    
    var pageSize: Int
    
    var pageOffSet: Int
    
    var totalSize: Int {
        return 100
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
        return DetailedNewsViewModel(news: news![selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    override init() {
        self.pageSize = 20
        self.pageOffSet = 0
//        self.news = [ShortNews(id: "1", title: "Тинькофф Банк вместе с фондом «Талант и Успех» займутся развитием инноваций и откроют Центр Разработки в Сочи", slug: "kkk"),
//        ShortNews(id: "2", title: "Центр Разработки в Сочи", slug: "kkk"),
//        ShortNews(id: "3", title: "Сочи", slug: "kkk")
//        ]
    }
    
}
