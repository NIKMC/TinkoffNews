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
    
    @IBOutlet weak var indicatorOfBottomPaging: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.black
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Upload News...")
        
        self.indicatorOfBottomPaging.isHidden = true
        
        
    }
    
    @IBOutlet var viewModel: TableViewModel!
    
    @objc func pullToRefresh() {
        viewModel.pullToRefresh { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
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
        
        viewModel.pagingNews(atIndexPath: indexPath, startAnimation: { [weak self] in
            DispatchQueue.main.async {
                self?.indicatorOfBottomPaging.isHidden = false
                self?.indicatorOfBottomPaging.startAnimating()
            }
        }) { [weak self] in
            DispatchQueue.main.async {
                self?.indicatorOfBottomPaging.isHidden = true
                self?.indicatorOfBottomPaging.stopAnimating()
                self?.tableView.reloadData()
            }
        }
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
                print("\(String(describing:  viewModel.viewModelForSelectedRow()?.title))")
                dvc.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }

}
