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

    @IBAction func didTapTakenButton(_ sender: Any) {
        print("vaccine marked as taken")
    }
}
