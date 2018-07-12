//
//  TableViewModelType.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 07/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

protocol TableViewModelType {
    
    var pageOffSet: Int { get}
    var pageSize: Int { get }
    
    func numberOfRowsInSection() -> Int
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> DetailedNewsViewModelType?
    
    func selectRow(atIndexPath indexPath: IndexPath)
    
    func pagingNews(atIndexPath indexPath: IndexPath, startAnimation: @escaping()->(), completion: @escaping ()->())
    
    func getNews(set: Int, size: Int, completion: @escaping ([ShortNews])->())
    
    func pullToRefresh(completion: @escaping ()->())
    
    func fetchListOfNews() 
}
