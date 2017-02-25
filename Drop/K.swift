//
//  K.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import Foundation

struct K {
    
    struct Initial {
        
        struct Vaccines {
            
            fileprivate enum Agent: String {
                case flu = "Flu"
                case tetanus = "Tetanus"
                case hepatitis = "Hepatitis"
                case tuberculosis = "Tuberculosis"
            }
            
            static let forChildren: [Vaccine] = [
                Vaccine(title: Agent.flu.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.flu.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.tetanus.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.hepatitis.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.hepatitis.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.hepatitis.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.hepatitis.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.tuberculosis.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.tuberculosis.rawValue, estimateDate: Date()),
                Vaccine(title: Agent.tuberculosis.rawValue, estimateDate: Date())
            ]
        
        }
        
    }
    
}
