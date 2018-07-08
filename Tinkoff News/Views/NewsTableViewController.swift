//
//  NewsTableViewController.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

//    var storage: StorableContext?
//    var itemArray: [News]?
    
//    var pageOffset = 0
//    let pageSize = 20
//    let totalSize = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
//        storage = CoreDataStorageContext()
        
        
        self.refreshControl?.addTarget(self, action: #selector(loadNews), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.black
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Upload News...")
        
    }
    
    @IBOutlet var viewModel: TableViewModel!
    

    //MARK: - Loading first data
    
    @objc func loadNews() {
//        let globalUrlString = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles"
//        let params: [String:String] = ["pageOffset" : String(describing: pageOffset), "pageSize" : String(describing: pageSize)]
//        createRequest(toUrlString: globalUrlString, params: params)
        
    }
    
    func createRequest(toUrlString urlString: String, params: [String:String]) {
        let urlComp = NSURLComponents(string: urlString)!
        
        urlComp.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        URLSession.shared.dataTask(with: urlComp.url!) { [unowned self](data, response, error) in
            guard let data = data else { return }
            print("The data: \(data)")
            print("The responce: \(String(describing: response))")
            do {
                let resp = try JSONDecoder().decode(ObjectOfNews.self, from: data)
                print("The response is: \(String(describing: resp.response.news.first))")
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
                
//                self.tableView.reloadData()
            } catch let error {
                print("Error of parsing \(error)")
            }
            
            }.resume()
    }
    

    // MARK: - Table view data source

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfSections(in: tableView, count: viewModel.numberOfRowsInSection())
    }

    func numberOfSections(in tableView: UITableView, count numOfSections: Int) -> Int {
        if numOfSections > 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: tableView.bounds.size.height/4, width: tableView.bounds.size.width, height: tableView.bounds.size.height/2))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .singleLine
        }
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsViewTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        performSegue(withIdentifier: "goToDetailedNews", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        if identifier == "goToDetailedNews" {
            if let dvc = segue.destination as? DetailedNewsViewController {
                print("\(viewModel.viewModelForSelectedRow()?.title)")
            }
        }
    }

}
