//
//  ContactsProtocols.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

//MARK: ContactsViewProtocol

protocol ContactsViewProtocol: AnyObject {
    var vc: ContactsViewController? {get}
    func displayInfo(viewModel: ContactsViewModel.ViewModel)
    func displayError(error: String)
    func showProgress()
    func hideProgress()
    func updateView()
}

//MARK: ContactsInteractorProtocol

protocol ContactsInteractorProtocol {
    func loadData()
    func routeToSelectedContact(index: Int)
    func search(text: String)
}

//MARK: ContactsPresenterProtocol

protocol ContactsPresenterProtocol {
    func presentData(response: ContactsBusinessModel.BizModel)
    func route(routeModel: ContactsBusinessModel.RouteModel)
}

//MARK: MenuConfigurator Interface

protocol ContactsConfiguratorProtocol {
    func configure(view: ContactsViewController)
}

//MARK: DataProvider Interface

protocol ContactsDataProviderProtocol {
    func loadContactList(completion: @escaping ([ContactServiceModel.Response.contact]?, String?) -> Void)
    func getContacts(listType: ContactsDataProvider.ContactListType) -> [ContactServiceModel.Response.contact]
    func setContacts(contacts: [ContactServiceModel.Response.contact], listType: ContactsDataProvider.ContactListType)
}
