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
    @IBOutlet weak var date: UILabel!
    
    var vaccine: Vaccine! {
        didSet {
            toggleTakenButtonState(from: vaccine)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didTapTakenButton(_ sender: Any) {
        toggleVaccineTakenState(vaccine: vaccine!)
        toggleTakenButtonState(from: vaccine!)
    }
    
    func toggleVaccineTakenState(vaccine: Vaccine) {
        if vaccine.isTaken {
            vaccine.markNotTaken()
            print("Vaccine \(vaccine.title) marked as NOT taken.")
        } else {
            vaccine.markTaken()
            print("Vaccine \(vaccine.title) marked as taken.")
        }
    }
    
    func toggleTakenButtonState(from vaccine: Vaccine) {
        takenButton.backgroundColor = vaccine.isTaken
            ? UIColor.blue
            : UIColor.gray
    }
}
