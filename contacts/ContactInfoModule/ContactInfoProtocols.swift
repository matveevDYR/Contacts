//
//  ContactInfoProtocols.swift
//  ContactInfo
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

//MARK: ContactInfoViewProtocol

protocol ContactInfoViewProtocol: AnyObject {
    func displayInfo(viewModel: ContactInfoViewModel.ViewModel)
}

//MARK: ContactInfoInteractorProtocol

protocol ContactInfoInteractorProtocol {
    func loadData()
}

//MARK: ContactInfoPresenterProtocol

protocol ContactInfoPresenterProtocol {
    func presentData(response: ContactInfoBusinessModel.BizModel)
}

//MARK: MenuConfigurator Interface

protocol ContactInfoConfiguratorProtocol {
    func configure(view: ContactInfoViewController)
}

//MARK: DataProvider Interface

protocol ContactInfoDataProviderProtocol {
    func getContact() -> ContactServiceModel.Response.contact
}
