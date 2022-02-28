//
//  ContactPhoneTableViewCell.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

enum ContactPhoneCell {
    struct ViewModel {
        let phone: String
        let phoneLink: URL?
    }
}

class ContactPhoneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBAction func phoneButtonAction(_ sender: Any) {
        guard let link = phoneLink else {return}
        UIApplication.shared.open(link)
    }
    
    private var phoneLink: URL?
    
    var viewModel: ContactPhoneCell.ViewModel? {
        didSet {
            phoneLabel.text = viewModel?.phone
            phoneLink = creatingPhoneLink(phone: viewModel?.phone)
        }
    }
    
    private func creatingPhoneLink(phone: String?) -> URL? {
        guard let phone = phone else {return nil}
        let clearPhone = phone.replaceExtraSymbols(symbols: [" ", "+", "(", ")", "-"])
        let phoneLink = URL(string: "tel://\(clearPhone)")
        return phoneLink
    }
    
}
