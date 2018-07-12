//
//  BackedService.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 11/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation

public protocol BackendService {
    
    func request(_ request: BackedAPIRequest,
                 success: ((Data)->())?,
                 failure: ((NSError)->())?)
    
    func cancel()
}
