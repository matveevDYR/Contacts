//
//  ContactBiographyTableViewCell.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

enum ContactBiographyCell {
    struct ViewModel {
        let biography: String
    }
}

class ContactBiographyTableViewCell: UITableViewCell {

    @IBOutlet weak var biographyLabel: UILabel!
    
    var viewModel: ContactBiographyCell.ViewModel? {
        didSet {
            biographyLabel.text = viewModel?.biography
        }
    }
    
}
