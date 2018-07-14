//
//  Utility.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 14/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

public class Utility {
    
    
    //MARK: parse string datetime to good datetime
    static func parseDateTimeString(oddDateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: oddDateTime) else {
            //            fatalError("ERROR: Date conversion failed due to mismatched format.")
            return oddDateTime
        }
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createDate = dateFormatterString.string(from: date)
        return createDate
        
    }
    
}

//MARK: parse html text to common text

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


