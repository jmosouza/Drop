//
//  VaccineTableViewCell.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineTableViewCell: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var vaccines = [Vaccine]()
    var delegate: VaccineDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.dataSource = self
    }

}

extension VaccineTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vaccines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = R.reuseIdentifier.vaccineCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! VaccineCollectionViewCell
        cell.vaccine = vaccines[indexPath.row]
        cell.delegate = delegate
        return cell
    }
    
}
