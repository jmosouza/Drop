//
//  VaccineCollectionViewCell.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vaccineToggle: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var delegate: VaccineDelegate?
    
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
        
        // Open vaccine detail after tapping
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapGesture(recognizer:)))
        
        // Toggle button when holding for a little while
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPressGesture))
        
        contentView.addGestureRecognizer(tapRecognizer)
        contentView.addGestureRecognizer(longPressRecognizer)
    }
    
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            print("Tapped on \(vaccine.title)")
            delegate?.didTap(vaccine: vaccine)
        }
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
        vaccineToggle.backgroundColor = vaccine.isTaken
            ? UIColor.blue
            : UIColor.gray
    }
}
