//
//  ViewController.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit
import CoreData

class VaccineGridViewController: UIViewController {
    
    let vaccineManager: VaccineManager = .shared

    var vaccines = [Vaccine]()
    var sectionTitles = [String]()
    var sectionVaccines = [[Vaccine]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vaccines = vaccineManager.vaccines() else {
            log.error("Missing vaccines")
            return
        }
        
        sectionTitles = vaccineTitlesOrderedAlphabetically(from: vaccines)
        sectionVaccines = vaccinesGroupedByTitle(from: vaccines, andTitles: sectionTitles)
    }
    
    fileprivate func vaccineTitlesOrderedAlphabetically(from vaccines: [Vaccine]) -> [String] {
        return vaccines
            .map { $0.title! }
            .sorted { $0 < $1 }
            .reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
    
    fileprivate func vaccinesGroupedByTitle(from vaccines: [Vaccine], andTitles titles: [String]) -> [[Vaccine]] {
        return titles.map { (title) in
            vaccines
                .filter { $0.title == title }
                .sorted { ($0.estimatedDate as! Date) < ($1.estimatedDate as! Date) }
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
