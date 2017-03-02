//
//  VaccineGridRow.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineGridRow: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var vaccines = [Vaccine]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.dataSource = self
    }

}

extension VaccineGridRow: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vaccines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = R.reuseIdentifier.vaccineCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! VaccineGridCell
        cell.vaccine = vaccines[indexPath.row]
        return cell
    }
    
}
