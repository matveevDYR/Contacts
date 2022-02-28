//
//  ContactTableViewCell.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

enum ContactCell {
    struct ViewModel {
        let name: String
        let phone: String
        let temperament: String
    }
}

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    
    var viewModel: ContactCell.ViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            phoneLabel.text = viewModel?.phone
            temperamentLabel.text = viewModel?.temperament
        }
    }
    
}
