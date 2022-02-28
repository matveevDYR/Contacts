//
//  ContactInfoPresenter.swift
//  ContactInfo
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

class ContactInfoPresenter {
    
    private unowned let view: ContactInfoViewProtocol
    
    required init(view: ContactInfoViewController) {
        self.view = view
    }
    
    //MARK: showSuccess
    
    private func showSuccess(response: ContactInfoBusinessModel.BizModel) {
        
        let startDate = response.contact.educationPeriod?.start?.formattingDate(fromMask: "yyyy-MM-dd'T'HH:mm:ssZ", toMask: "dd.MM.yyyy") ?? "???"
        let endDate = response.contact.educationPeriod?.end?.formattingDate(fromMask: "yyyy-MM-dd'T'HH:mm:ssZ", toMask: "dd.MM.yyyy") ?? "???"
        
        let educationPeriod = "\(startDate) - \(endDate)"
        
        let clearPhone = response.contact.phone?.replaceExtraSymbols(symbols: [" ", "+", "(", ")", "-"])
        let phone = clearPhone?.formattingByMask(replaceSymbols: [], mask: "+X XXX XXX-XX-XX", maskSymbol: "X") ?? "no phone"
        let phoneLink = clearPhone != nil ? URL(string: clearPhone!) : nil
        
        let contactHeaderCellViewModel = ContactHeaderCell.ViewModel(name: response.contact.name ?? "", educationPeriod: educationPeriod, temperament: response.contact.temperament?.getValue() ?? "")
        let contactPhoneCellViewModel = ContactPhoneCell.ViewModel(phone: phone, phoneLink: phoneLink)
        let contactBiographyCellViewModel = ContactBiographyCell.ViewModel(biography: response.contact.biography ?? "")
        
        let viewModel = ContactInfoViewModel.ViewModel(contactHeaderCellViewModel: contactHeaderCellViewModel, contactPhoneCellViewModel: contactPhoneCellViewModel, contactBiographyCellViewModel: contactBiographyCellViewModel)
        
        view.displayInfo(viewModel: viewModel)
    }
    
}

//MARK: Interface

extension ContactInfoPresenter: ContactInfoPresenterProtocol {
    
    func presentData(response: ContactInfoBusinessModel.BizModel) {
        showSuccess(response: response)
    }
    
}

