//
//  Vaccine.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import Foundation

class Vaccine {
    
    var title: String
    var estimateDate: Date
    
    /** Default initializer */
    init(title: String, estimateDate: Date) {
        self.title = title
        self.estimateDate = estimateDate
    }
    
    /** Initialize by adding an age to a birth date. */
    convenience init(title: String, birth: Date, age: TimeInterval) {
        let date = birth.addingTimeInterval(age)
        self.init(title: title, estimateDate: date)
    }
    
}
