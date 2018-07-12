//
//  TableViewCellViewModel.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    
    
    private var news: ShortNews
    
    var title: String {
        return news.title
    }
    var counter: String {
        return String(describing: news.counter)
    }
    
    init(news: ShortNews) {
        self.news = news
    }
    
}
