//
//  Vaccine.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import Foundation
import SwiftDate

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
    
    func markTaken() {
        self.dateTaken = dateEstimate
    }
    
    func markNotTaken() {
        self.dateTaken = nil
    }
    
    func readableIntervalTo(_ date: Date) -> String? {
        
        let selfDate = dateTaken ?? dateEstimate
        
        do {
            // Using SwiftDate's Time Components formatting.
            // http://malcommac.github.io/SwiftDate/formatters.html#timecomponents
            return try selfDate.timeComponents(
                to: date,
                options: ComponentsFormatterOptions(
                    allowedUnits: [.month, .year],
                    style: .full,
                    zero: .dropAll))
        } catch {
            print(error)
            return nil
        }
    }
    
}
