//
//  ViewController.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 05/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {

    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: DetailedNewsViewModelType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        //FIXME: Change on the News or something else instead of use this two parameters
        viewModel?.title.bind { [unowned self] in
            guard let title = $0 else { return }
            self.titleLabel.text = title
        }
        
        viewModel?.text.bind { [unowned self] in
            guard let text = $0 else { return }
            self.textLabel.text = text
        }
        
        viewModel?.date.bind { [unowned self] in
            guard let date = $0 else { return }
            self.dateTimeLabel.text = "Published: \(date)"
        }
        
        viewModel?.performUpdate(completion: { [weak self] (news) in
            DispatchQueue.main.async {
                self?.viewModel?.title.value = self?.viewModel?.parseHtmlText(fromHtmlText: news.title!)
                self?.viewModel?.text.value = self?.viewModel?.parseHtmlText(fromHtmlText: news.text!)
                self?.viewModel?.date.value = self?.viewModel?.parseDateTimeString(oddDateTime: news.createdTime!)
            }
        })
        
    }
  
}
