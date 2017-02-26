//
//  VaccineDetailViewController.swift
//  Drop
//
//  Created by João Marcelo on 26/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineDetailViewController: UIViewController {
    
    var vaccine: Vaccine?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if vaccine == nil {
            log.error("Vaccine is nil")
            dismiss(animated: true, completion: nil)
        }
    }

}

extension VaccineDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "card") else {
            fatalError("Can't dequeue cell")
        }
        return cell
    }
}
