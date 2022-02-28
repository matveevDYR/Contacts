//
//  ContactInfoRouter.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation
import UIKit

class ContactInfoRouter {
    
    static func toContactInfo(from: UIViewController, contact: ContactServiceModel.Response.contact) {
        let toVc = UIStoryboard(name: "ContactInfo", bundle: nil).instantiateViewController(withIdentifier: ContactInfoViewController.nibName) as! ContactInfoViewController
            
        let presenter = ContactInfoPresenter(view: toVc)
        let dataProvider = ContactInfoDataProvider(contact: contact)
        let interactor = ContactInfoInteractor(presenter: presenter, dataProvider: dataProvider)
        
        toVc.interactor = interactor
        
        from.navigationController?.pushViewController(toVc, animated: true)
    }
    
}

