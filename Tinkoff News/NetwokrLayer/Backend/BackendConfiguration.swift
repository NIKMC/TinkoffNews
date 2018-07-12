//
//  BackendConfiguration.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

public final class BackendConfiguration {
    let apiURL: URL
    
    public init(apiURL: URL){
        self.apiURL = apiURL
    }
    
    public static var shared: BackendConfiguration!
    
}
