//
//  ViewController.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VaccineDetailViewController {
            vc.vaccine = selectedVaccine
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.vaccineRow.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! VaccineTableViewCell? else {
            log.severe("Can't dequeue reusable cell with identifier \(identifier)")
            fatalError()
        }
        cell.titleLabel.text = sectionTitles[indexPath.row]
        cell.vaccines = sectionVaccines[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

protocol VaccineDelegate {
    
    func didTap(vaccine: Vaccine)
    
}

extension ViewController: VaccineDelegate {
    
    func didTap(vaccine: Vaccine) {
        selectedVaccine = vaccine
        let segue = R.segue.viewController.vaccineDetail
        performSegue(withIdentifier: segue, sender: nil)
    }
    
}
