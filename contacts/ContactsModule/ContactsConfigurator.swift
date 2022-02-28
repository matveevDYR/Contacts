//
//  ContactsConfigurator.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactsConfigurator: ContactsConfiguratorProtocol {
    func configure(view: ContactsViewController) {
        
        let service = DIAssembly.instance().apiService
        
        let dataProvider = ContactsDataProvider(service: service)
        let presenter = ContactsPresenter(view: view)
        let interactor = ContactsInteractor(presenter: presenter, dataProvider: dataProvider)
            
        view.interactor = interactor
    }
}
