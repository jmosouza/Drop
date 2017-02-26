//
//  K.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import Foundation
import SwiftDate

struct K {
    
    struct Initial {
        
        struct Vaccines {
            
            // TODO: Get birth from profile
            static let birth = Date()
            
            fileprivate enum Agent: String {
                case hepatitisB = "Hepatitis B"
                case rotavirus = "Rotavirus"
                case dtap = "DTaP"
            }
            
            static let usaBirthToFifteenMonths_2017_02: [Vaccine] = [
                Vaccine(title: Agent.hepatitisB.rawValue, dateEstimate: 0.months.from(date: birth)!),
                Vaccine(title: Agent.hepatitisB.rawValue, dateEstimate: 1.months.from(date: birth)!),
                Vaccine(title: Agent.hepatitisB.rawValue, dateEstimate: 6.months.from(date: birth)!),
                Vaccine(title: Agent.rotavirus.rawValue, dateEstimate: 2.months.from(date: birth)!),
                Vaccine(title: Agent.rotavirus.rawValue, dateEstimate: 4.months.from(date: birth)!),
                Vaccine(title: Agent.dtap.rawValue, dateEstimate: 2.months.from(date: birth)!),
                Vaccine(title: Agent.dtap.rawValue, dateEstimate: 4.months.from(date: birth)!),
                Vaccine(title: Agent.dtap.rawValue, dateEstimate: 6.months.from(date: birth)!),
                Vaccine(title: Agent.dtap.rawValue, dateEstimate: 15.months.from(date: birth)!)
            ]
        
        }
        
    }
    
}
