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
    var dateEstimate: Date
    var dateTaken: Date?
    
    var isTaken: Bool {
        get {
            return dateTaken != nil
        }
    }
    
    /** Default initializer */
    init(title: String, dateEstimate: Date) {
        self.title = title
        self.dateEstimate = dateEstimate
    }
    
    /** Initialize by adding an age to a birth date. */
    convenience init(title: String, birth: Date, age: TimeInterval) {
        let date = birth.addingTimeInterval(age)
        self.init(title: title, dateEstimate: date)
    }
    
    func markTaken(date: Date = Date()) {
        self.dateTaken = date
    }
    
    func markNotTaken() {
        self.dateTaken = nil
    }
    
}
