//
//  ContactsDataProvider.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactsDataProvider {
    
    enum ContactListType {
        case base
        case filtred
    }
    
    private weak var service: ContactsServiceProtocol?
    private let links = ["https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json",
                             "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-02.json",
                             "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-03.json"]
    private var contacts: [ContactServiceModel.Response.contact] = []
    private var filtredContactList: [ContactServiceModel.Response.contact] = []
    
    
    required init(service: ContactsServiceProtocol) {
        self.service = service
    }
    
}

//MARK: Interface

extension ContactsDataProvider: ContactsDataProviderProtocol {
    
    func loadContactList(completion: @escaping ([ContactServiceModel.Response.contact]?, String?) -> Void) {
        
        let queue = DispatchQueue.global(qos: .utility)
        let dispatchGroup = DispatchGroup()
        var result: [ContactServiceModel.Response.contact] = []
        var responseError: String?
        
        links.forEach { link in
            dispatchGroup.enter()
            queue.async {
                self.service?.loadContactList(link: link, completion: { response, error in
                    if error == nil {
                        if let response = response {
                            result.append(contentsOf: response)
                        }
                    } else {
                        responseError = error
                    }
                    dispatchGroup.leave()
                })
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(result, responseError)
        }
        
    }
    
    func getContacts(listType: ContactsDataProvider.ContactListType) -> [ContactServiceModel.Response.contact] {
        switch listType {
        case .base: return contacts
        case .filtred: return filtredContactList
        }
    }
    
    func setContacts(contacts: [ContactServiceModel.Response.contact], listType: ContactsDataProvider.ContactListType) {
        switch listType {
        case .base:
            self.contacts = contacts
            filtredContactList = contacts
        case .filtred:
            filtredContactList = contacts
        }
    }
    
}
