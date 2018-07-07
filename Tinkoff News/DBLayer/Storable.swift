//
//  Storable.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import Foundation
import CoreData

protocol Storable {
}

extension NSManagedObject: Storable {
    
}

extension NewsJSON: Storable{
    
}
