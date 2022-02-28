//
//  ContactsBusinessModel.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

enum ContactsBusinessModel {
    
    enum ViewState {
        case loading
        case success
        case error
    }
    
    struct BizModel {
        
        var contacts: [ContactServiceModel.Response.contact]?
        
        var viewState: ViewState?
        var error: String?
    }
    
    enum RouteWay {
        case routeToContact
    }
    
    struct RouteModel {
        let contact: ContactServiceModel.Response.contact?
        let routeWay: RouteWay
    }
}
