//
//  DIAssembly.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation
import EasyDi


class DIAssembly: Assembly {
    
    var apiService: APIService {
        return define(scope: .lazySingleton, init: APIService()) {
            return $0
        }
    }
    
}
