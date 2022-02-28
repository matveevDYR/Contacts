//
//  ContactsInteractor.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactsInteractor {
    
    private var presenter: ContactsPresenterProtocol!
    private var dataProvider: ContactsDataProviderProtocol!
    
    required init(presenter: ContactsPresenterProtocol, dataProvider: ContactsDataProviderProtocol) {
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
    
    private func sendLoadingResponse() {
        var response = ContactsBusinessModel.BizModel()
        response.viewState = .loading
        presenter.presentData(response: response)
    }
    
    private func sendSuccessResponse(contacts: [ContactServiceModel.Response.contact]) {
        var response = ContactsBusinessModel.BizModel()
        response.contacts = contacts
        response.viewState = .success
        presenter.presentData(response: response)
    }
    
    private func sendRouteResponse(routeModel: ContactsBusinessModel.RouteModel) {
        presenter.route(routeModel: routeModel)
    }
    
    private func sendErrorResponse(error: String) {
        var response = ContactsBusinessModel.BizModel()
        response.viewState = .error
        response.error = error
        presenter.presentData(response: response)
    }
    
}

//MARK: Interface

extension ContactsInteractor: ContactsInteractorProtocol {
    
    func loadData() {
        sendLoadingResponse()
        dataProvider.loadContactList { [weak self] response, error in
            guard error == nil else {self?.sendErrorResponse(error: error!); return}
            guard let contacts = response else {self?.sendSuccessResponse(contacts: []); return}
            let newContactList = contacts.sorted(by: {$0.name! < $1.name!})
            self?.dataProvider.setContacts(contacts: newContactList, listType: .base)
            self?.sendSuccessResponse(contacts: newContactList)
        }
    }
    
    func routeToSelectedContact(index: Int) {
        let contacts = dataProvider.getContacts(listType: .filtred)
        guard let contact = contacts[safe: index] else { return }
        let routeModel = ContactsBusinessModel.RouteModel(contact: contact, routeWay: .routeToContact)
        sendRouteResponse(routeModel: routeModel)
    }
    
    func search(text: String) {
        let clearedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let contacts = dataProvider.getContacts(listType: .base)
        guard clearedText != "" else {
            dataProvider.setContacts(contacts: contacts, listType: .filtred)
            sendSuccessResponse(contacts: contacts)
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let newContactList = contacts.filter {
                let clearPhone = $0.phone?.replaceExtraSymbols(symbols: [" ", "+", "(", ")", "-"]) ?? ""
                return $0.name?.contains(clearedText) ?? false || $0.phone?.contains(clearedText) ?? false || clearPhone.contains(clearedText) || $0.temperament?.getValue().contains(clearedText) ?? false
            }
            DispatchQueue.main.async {
                self.dataProvider.setContacts(contacts: newContactList, listType: .filtred)
                self.sendSuccessResponse(contacts: newContactList)
            }
            
        }
    }
    
}
