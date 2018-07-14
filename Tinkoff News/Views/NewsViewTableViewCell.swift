//
//  NewsViewTableViewCell.swift
//  Tinkoff News
//
//  Created by Ivan Nikitin on 06/07/2018.
//  Copyright © 2018 Иван Никитин. All rights reserved.
//

import UIKit

class NewsViewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleNewsLabel.text = viewModel.title
            counterLabel.text = viewModel.counter
        }
    }
    
    
}
