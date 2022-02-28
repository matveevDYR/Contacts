//
//  ArrayCollectionExtension.swift
//  contacts
//
//  Created by Денис Матвеев on 27.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
