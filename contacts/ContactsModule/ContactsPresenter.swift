//
//  ContactsPresenter.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactsPresenter {
    
    private unowned let view: ContactsViewProtocol
    
    required init(view: ContactsViewController) {
        self.view = view
    }
    
    //MARK: Error
    
    private func showError(error: String) {
        view.displayError(error: error)
    }
    
    //MARK: showSuccess
    
    private func showSuccess(response: ContactsBusinessModel.BizModel) {
        
        let contactCellViewModels = response.contacts?.map {
            ContactCell.ViewModel(name: $0.name ?? "",
                                  phone: $0.phone?.formattingByMask(replaceSymbols: [" ", "+", "(", ")", "-"], mask: "+X XXX XXX-XX-XX", maskSymbol: "X") ?? "no phone",
                                  temperament: $0.temperament?.getValue() ?? "")
        }

        let viewModel = ContactsViewModel.ViewModel(contactCellViewModels: contactCellViewModels ?? [])
        view.displayInfo(viewModel: viewModel)
        view.updateView()
    }
    
    //MARK: Route
    
    private func makeRoute(routeModel: ContactsBusinessModel.RouteModel) {
        guard let fromVC = view.vc else {return}
        switch routeModel.routeWay {
        case .routeToContact:
            guard let contact = routeModel.contact else {return}
            ContactInfoRouter.toContactInfo(from: fromVC, contact: contact)
        }
    }
    
}

//MARK: Interface

extension ContactsPresenter: ContactsPresenterProtocol {
    
    func presentData(response: ContactsBusinessModel.BizModel) {
        guard let viewState = response.viewState else { return }
        switch viewState {
        case .loading:
            view.showProgress()
        case .error:
            view.hideProgress()
            showError(error: response.error!)
        case .success:
            view.hideProgress()
            showSuccess(response: response)
        }
    }
    
    func route(routeModel: ContactsBusinessModel.RouteModel) {
        makeRoute(routeModel: routeModel)
    }
    
}

