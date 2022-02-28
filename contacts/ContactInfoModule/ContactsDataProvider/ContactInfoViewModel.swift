//
//  ContactInfoViewModel.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

enum ContactInfoViewModel {
    
    struct ViewModel {
        let contactHeaderCellViewModel: ContactHeaderCell.ViewModel
        let contactPhoneCellViewModel: ContactPhoneCell.ViewModel
        let contactBiographyCellViewModel: ContactBiographyCell.ViewModel
    }
}
