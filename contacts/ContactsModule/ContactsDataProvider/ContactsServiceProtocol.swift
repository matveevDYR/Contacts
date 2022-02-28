//
//  ContactsServiceProtocol.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

protocol ContactsServiceProtocol: AnyObject {
    func loadContactList(link: String, completion: @escaping ([ContactServiceModel.Response.contact]?, String?) -> Void)
}

extension ContactsServiceProtocol where Self: APIService {
    func loadContactList(link: String, completion: @escaping ([ContactServiceModel.Response.contact]?, String?) -> Void) {
        convertResult(URLString: link, requestType: .get, params: nil, completion: completion)
    }
}
