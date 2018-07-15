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
        
        guard let viewModel = viewModel else { return }
        viewModel.performUpdate(completion: { [unowned self] (news) in
            DispatchQueue.main.async {
                self.viewModel?.titleBox.value = news.title
                self.viewModel?.textBox.value = news.text
                self.viewModel?.publishedDateBox.value = news.createdTime
            }
            }, errorHandle: { [weak self] (error) in
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                    ac.addAction(cancelAction)
                    self?.present(ac, animated: true)
                }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        guard let viewModel = viewModel else { return }
        self.titleLabel.text = viewModel.title.htmlToString
        
        viewModel.titleBox.bind{ [unowned self] in
            guard let title = $0 else { return }
            self.titleLabel.text = title.htmlToString
        }
        viewModel.textBox.bind{ [unowned self] in
            guard let text = $0 else { return }
            self.textLabel.text = text.htmlToString
        }
        viewModel.publishedDateBox.bind{ [unowned self] in
            guard let dateTime = $0 else { return }
            let publishedDate = Utility.parseDateTimeString(oddDateTime: dateTime)
            self.dateTimeLabel.text = "Published: \(String(describing: publishedDate))"
        }
        
        viewModel.performLoad(completion: { [unowned self] (news) in
            self.viewModel?.titleBox.value = news.title
            self.viewModel?.textBox.value = news.text
            self.viewModel?.publishedDateBox.value = news.createdTime
        })
        
    }
    
}
