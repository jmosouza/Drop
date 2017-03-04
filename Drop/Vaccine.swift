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
    var estimatedDate: Date
    var recordedDate: Date?
    var managedObject: VaccineMO?
    
    var isTaken: Bool {
        get {
            return recordedDate != nil
        }
    }
    
    // MARK - Init
    
    /** Default initializer */
    init(title: String, recordedDate: Date? = nil, estimatedDate: Date) {
        self.title = title
        self.recordedDate = recordedDate
        self.estimatedDate = estimatedDate
    }
    
    /** Initialize by adding an age to a birth date. */
    convenience init(title: String, birth: Date, age: TimeInterval) {
        let date = birth.addingTimeInterval(age)
        self.init(title: title, estimatedDate: date)
    }
    
    /** Initialize from a managed object. */
    convenience init(managedObject: VaccineMO) {
        self.init(
            title: managedObject.title!,
            recordedDate: managedObject.recordedDate as Date?,
            estimatedDate: managedObject.estimatedDate! as Date)
        self.managedObject = managedObject
    }
    
    // MARK - Misc
    
    func save() {
        guard managedObject != nil else {
            log.debug("Vaccine has no managed object")
            return
        }
        managedObject!.title = title
        managedObject!.recordedDate = recordedDate as NSDate?
        managedObject!.estimatedDate = estimatedDate as NSDate?
        do {
            try managedObject!.managedObjectContext?.save()
            log.debug("Vaccine saved managed object")
        }
        catch {
            log.debug("Vaccine can't save managed object")
            log.error(error)
        }
    }
    
    /** 
     Set the value of recordedDate. If currently nil, set to estimatedDate. If currently has a value, set to nil.
     */
    func toggleState() {
        recordedDate = recordedDate == nil
            ? estimatedDate
            : nil
        save()
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
            let vaccinationDate = recordedDate ?? estimatedDate
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
        guard let age = readableAge(forBirthDate: birthDate) else {
            return nil
        }
        let taken = isTaken
            ? NSLocalizedString("Vaccinated", comment: "Indicates that the vaccine is taken.")
            : NSLocalizedString("Not vaccinated", comment: "Indicates that the vaccine is not taken.")
        let label = [title, age, taken].joined(separator: ", ")
        return label
    }
    
}
