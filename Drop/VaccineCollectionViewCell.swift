//
//  VaccineCollectionViewCell.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var takenButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var vaccine: Vaccine! {
        didSet {
            // TODO: Get birth from profile
            let birth = K.Initial.Vaccines.birth
            dateLabel.text = vaccine.readableIntervalTo(birth)
            toggleTakenButtonState(from: vaccine)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Toggle button when holding for a little while
        let longPressRecognizer =
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPressGesture))
        takenButton.addGestureRecognizer(longPressRecognizer)
    }
    
    func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            toggleVaccineTakenState(vaccine: vaccine!)
            toggleTakenButtonState(from: vaccine!)
        }
    }
    
    func toggleVaccineTakenState(vaccine: Vaccine) {
        if vaccine.isTaken {
            vaccine.markNotTaken()
            print("\(vaccine.title) vaccine marked as NOT taken.")
        } else {
            vaccine.markTaken()
            print("\(vaccine.title) vaccine marked as taken.")
        }
    }
    
    func toggleTakenButtonState(from vaccine: Vaccine) {
        takenButton.backgroundColor = vaccine.isTaken
            ? UIColor.blue
            : UIColor.gray
    }
}
