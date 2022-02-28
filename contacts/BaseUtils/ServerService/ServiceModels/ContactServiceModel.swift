//
//  ContactServiceModel.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

enum ContactServiceModel {
    
    struct Response {
        
        struct contact: Codable {
            let id: String?
            let name: String?
            let phone: String?
            let height: Float?
            let biography: String?
            let temperament: temperament?
            let educationPeriod: educationPeriod?
        }
        
        enum temperament: String, Codable {
            case melancholic = "melancholic"
            case phlegmatic = "phlegmatic"
            case sanguine = "sanguine"
            case choleric = "choleric"
            
            func getValue() -> String {
                switch self {
                case .melancholic: return "Melancholic"
                case .phlegmatic: return "Phlegmatic"
                case .sanguine: return "Sanguine"
                case .choleric: return "Choleric"
                }
            }
        }
        
        struct educationPeriod: Codable {
            let start: String?
            let end: String?
        }
    }
}
