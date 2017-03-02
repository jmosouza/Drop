//
//  VaccineGridCell.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineGridCell: UICollectionViewCell {
    
    @IBOutlet weak var vaccineToggle: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var vaccine: Vaccine!
    let birth = K.Initial.Vaccines.birth
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Toggle button when holding for a little while
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPressGesture))
        contentView.addGestureRecognizer(longPressRecognizer)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        refreshContent()
    }
    
    // MARK: - Gestures
    
    func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            toggleVaccineTakenState(vaccine: vaccine!)
            refreshContent()
            
            // Announce vaccine state out load.
            UIAccessibilityPostNotification(
                UIAccessibilityAnnouncementNotification,
                accessibilityAnnouncementFor(vaccine: vaccine))
        }
    }
    
    // MARK: - Misc
    
    fileprivate func refreshContent() {
        toggleTakenButtonState(from: vaccine)
        dateLabel.text = vaccine.readableAge(forBirthDate: birth)
        vaccineToggle.accessibilityHint = accessibilityHintFor(vaccine: vaccine)
        vaccineToggle.accessibilityLabel = vaccine.accessibilityLabel(forBirthDate: birth)
    }
    
    fileprivate func toggleVaccineTakenState(vaccine: Vaccine) {
        if vaccine.isTaken {
            vaccine.markNotTaken()
        } else {
            vaccine.markTaken()
        }
    }
    
    fileprivate func toggleTakenButtonState(from vaccine: Vaccine) {
        vaccineToggle.backgroundColor = vaccine.isTaken
            ? UIColor.blue
            : UIColor.gray
    }
    
    fileprivate func accessibilityHintFor(vaccine: Vaccine) -> String {
        return vaccine.isTaken
            ? NSLocalizedString(
                "Keep pressed to mark as not vaccinated",
                comment: "Accessibility hint for the vaccination buttons")
            : NSLocalizedString(
                "Keep pressed to mark as vaccinated",
                comment: "Accessibility hint for the vaccination buttons")
    }
    
    fileprivate func accessibilityAnnouncementFor(vaccine: Vaccine) -> String {
        return vaccine.isTaken
            ? NSLocalizedString(
                "Vaccinated",
                comment: "Indicates that the vaccine is taken")
            : NSLocalizedString(
                "Not vaccinated",
                comment: "Indicates that the vaccine is not taken")
    }
}
