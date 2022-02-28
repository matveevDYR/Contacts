//
//  ContactInfoDataProvider.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactInfoDataProvider {
    
    private var contact: ContactServiceModel.Response.contact
    
    required init(contact: ContactServiceModel.Response.contact) {
        self.contact = contact
    }
    
}

//MARK: Interface

extension ContactInfoDataProvider: ContactInfoDataProviderProtocol {
    
    func getContact() -> ContactServiceModel.Response.contact {
        return contact
    }
    
}
