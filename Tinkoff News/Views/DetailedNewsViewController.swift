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
        
//        guard let viewModel = viewModel else { return }
        
//        self.titleLabel.text = viewModel.title
        
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
                self?.viewModel?.title.value = self?.viewModel?.parseHtmlText(fromHtmlText: news.title)
                self?.viewModel?.text.value = self?.viewModel?.parseHtmlText(fromHtmlText: news.text)
                self?.viewModel?.date.value = self?.viewModel?.parseDateTimeString(oddDateTime: news.createdTime)
            }
        })
//        viewModel?.getArticle(urlSlug: <#T##String#>, completion: <#T##(FullNewsJson) -> ()#>)
        
    }
    
    func performUpdate() {
        
    }
    
    //MARK: create request for detailed news with parametrs
    
    func createRequest(toUrlString urlString: String, params: [String:String]) {
        let urlComp = NSURLComponents(string: urlString)!
        
        urlComp.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        URLSession.shared.dataTask(with: urlComp.url!) { [unowned self] (data, response, error) in
            guard let data = data else { return }
            print("The data: \(data)")
            print("The responce: \(String(describing: response))")
            do {
                let resp = try JSONDecoder().decode(Response.self, from: data)
                print("The response is: \(resp)")
                DispatchQueue.main.async {
                    self.titleLabel.text = resp.response.title
//                    self.dateTimeLabel.text = parseDateTimeString(oddDateTime: resp.response.createdTime)
//                    self.textLabel = parseText(fromJsonText: resp.response.text)
                    self.dateTimeLabel.text = resp.response.createdTime
                    self.textLabel.text = resp.response.text
                }
                
            } catch let error {
                print("Error of parsing \(error)")
            }
            }.resume()
    }
    
  
}
