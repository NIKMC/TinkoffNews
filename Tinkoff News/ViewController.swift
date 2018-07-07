//
//  ViewController.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 05/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let globalUrlString = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle"
        
        let params: [String:String] = ["urlSlug": "01062018-tinkoff-bank-skolkovo-startup-village-agreements"]
        createRequest(toUrlString: globalUrlString, params: params)
        
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
                let resp = try JSONDecoder().decode(NewsJSON.self, from: data)
                print("The response is: \(resp)")
                DispatchQueue.main.async {
                    self.titleLabel.text = resp.response.title
                    self.parseDateTimeString(oddDateTime: resp.response.createdTime)
                    self.parseText(fromJsonText: resp.response.text)
                }
                
            } catch let error {
                print("Error of parsing \(error)")
            }
            
            }.resume()
    }
    
    //MARK: parse string datetime to good datetime
    
    func parseDateTimeString(oddDateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: oddDateTime) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createDate = dateFormatter2.string(from: date)
        print("The converted dateTime is \( createDate )")
        dateTimeLabel.text = createDate
        
        
    }
    
    func parseText(fromJsonText toText: String) {
        let convertedText = toText.htmlToString
        print("The value is: \(convertedText)")
        textLabel.text = convertedText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: Convert html String to String

extension Data {
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        return Data(utf8).htmlToAttributedString
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

