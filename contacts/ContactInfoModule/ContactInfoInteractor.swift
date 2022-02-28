//
//  ContactInfoInteractor.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactInfoInteractor {
    
    private var presenter: ContactInfoPresenterProtocol!
    private var dataProvider: ContactInfoDataProviderProtocol!
    
    required init(presenter: ContactInfoPresenterProtocol, dataProvider: ContactInfoDataProviderProtocol) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    private func sendSuccessResponse(contact: ContactServiceModel.Response.contact) {
        let response = ContactInfoBusinessModel.BizModel(contact: contact)
        presenter.presentData(response: response)
    }
    
}

//MARK: Interface

extension ContactInfoInteractor: ContactInfoInteractorProtocol {
    
    func loadData() {
        let contact = dataProvider.getContact()
        sendSuccessResponse(contact: contact)
    }
    
}
