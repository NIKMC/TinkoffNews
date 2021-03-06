//
//  NewsTableViewController.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    @IBOutlet weak var indicatorOfBottomPaging: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UIApplication.shared.statusBarStyle = .lightContent
        self.tableView.separatorColor = UIColor.white
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.black
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Upload News...")
        
        self.indicatorOfBottomPaging.isHidden = true
        
        viewModel.fetchListOfNews { [weak self] in
            self?.tableView.reloadData()
        }
        
        pullToRefresh()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let indexPath = viewModel.updateSelectedRow() else { return }
        print("update cell with indexPath = \(indexPath.row)")
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    @IBOutlet var viewModel: TableViewModel!
    
    @objc func pullToRefresh() {
        viewModel.loadToRefresh(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
            }, errorHandle: { [weak self] (errorInfo) in
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Ошибка!", message: errorInfo, preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                    ac.addAction(cancelAction)
                    self?.present(ac, animated: true)
                    self?.refreshControl?.endRefreshing()
                }
        })
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            }, completion:  { [weak self] in
                DispatchQueue.main.async {
                    self?.indicatorOfBottomPaging.isHidden = true
                    self?.indicatorOfBottomPaging.stopAnimating()
                    self?.tableView.reloadData()
                }
            }, errorHandle: { [weak self] (errorInfo) in
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Ошибка!", message: errorInfo, preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                    ac.addAction(cancelAction)
                    self?.present(ac, animated: true)
                    self?.indicatorOfBottomPaging.isHidden = true
                    self?.indicatorOfBottomPaging.stopAnimating()
                }
        })
        
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
                dvc.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }
    
}
