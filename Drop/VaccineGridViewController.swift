//
//  ViewController.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineGridViewController: UIViewController {

    var vaccines = K.Initial.Vaccines.usaBirthToFifteenMonths_2017_02
    var sectionTitles = [String]()
    var sectionVaccines = [[Vaccine]]()
    
    var selectedVaccine: Vaccine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTitles = vaccineTitlesOrderedAlphabetically(from: vaccines)
        sectionVaccines = vaccinesGroupedByTitle(from: vaccines, andTitles: sectionTitles)
    }
    
    fileprivate func vaccineTitlesOrderedAlphabetically(from vaccines: [Vaccine]) -> [String] {
        return vaccines
            .map { $0.title }
            .sorted { $0 < $1 }
            .reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
    
    fileprivate func vaccinesGroupedByTitle(from vaccines: [Vaccine], andTitles titles: [String]) -> [[Vaccine]] {
        return titles.map { (title) in
            vaccines.filter { $0.title == title }
        }
    }
    
}

extension VaccineGridViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.vaccineRow.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! VaccineGridRow
        cell.titleLabel.text = sectionTitles[indexPath.row]
        cell.vaccines = sectionVaccines[indexPath.row]
        return cell
    }
    
}
