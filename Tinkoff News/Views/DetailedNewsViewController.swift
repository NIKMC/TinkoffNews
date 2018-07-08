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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        let globalUrlString = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle"
        let params: [String:String] = ["urlSlug": "01062018-tinkoff-bank-skolkovo-startup-village-agreements"]
//        createRequest(toUrlString: globalUrlString, params: params)
        
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
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: Convert html String to String

