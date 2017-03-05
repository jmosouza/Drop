//
//  Vaccine.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import Foundation
import SwiftDate

extension Vaccine {
    
    var isTaken: Bool {
        get {
            return recordedDate != nil
        }
    }
    
    /**
     Set the value of recordedDate. If currently nil, set to estimatedDate. If currently has a value, set to nil.
     */
    func toggleState() {
        recordedDate = recordedDate == nil
            ? estimatedDate
            : nil
    }
    
    /**
     Returns a text representing the interval since the birth date.
     This function uses [SwiftDate Time Components](http://malcommac.github.io/SwiftDate/formatters.html#timecomponents).
     Example results:
     
     - 1 year, 3 months
     - 3 months
     - 0 month
     
     - returns: A text representing the interval since the birth date.
     */
    func readableAge(forBirthDate birthDate: Date) -> String? {
        do {
            let vaccinationDate = estimatedDate as! Date
            return try vaccinationDate.timeComponents(
                to: birthDate,
                options: ComponentsFormatterOptions(
                    allowedUnits: [.month, .year],
                    style: .full,
                    zero: .dropAll))
        } catch {
            log.error(error)
            return nil
        }
    }
    
    /**
     Returns a text description designed for screen readers.
     Example results:
     
     - Rotavirus, 4 months, Vaccinated
     - DTaP, 1 year, 3 months, Not vaccinated
     
     - returns: A text description designed for screen readers.
     */
    func accessibilityLabel(forBirthDate birthDate: Date) -> String? {
        guard let title = self.title else {
            log.error("Missing title")
            return nil
        }
        guard let age = readableAge(forBirthDate: birthDate) else {
            log.error("Missing age")
            return nil
        }
        let taken = isTaken
            ? NSLocalizedString("Vaccinated", comment: "Indicates that the vaccine is taken.")
            : NSLocalizedString("Not vaccinated", comment: "Indicates that the vaccine is not taken.")
        let label = [title, age, taken].joined(separator: ", ")
        return label
    }
    
}
