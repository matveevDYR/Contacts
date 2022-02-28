//
//  ContactHeaderTableViewCell.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

enum ContactHeaderCell {
    struct ViewModel {
        let name: String
        let educationPeriod: String
        let temperament: String
    }
}

class ContactHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var educationPeriodLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    
    var viewModel: ContactHeaderCell.ViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            educationPeriodLabel.text = viewModel?.educationPeriod
            temperamentLabel.text = viewModel?.temperament
        }
    }
    
}
