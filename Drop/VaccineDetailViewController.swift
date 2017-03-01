//
//  VaccineDetailViewController.swift
//  Drop
//
//  Created by João Marcelo on 26/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class VaccineDetailViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var vaccine: Vaccine?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.contentInset = UIEdgeInsets(
            top: 200,
            left: 0,
            bottom: 0,
            right: 0)
        
        if vaccine == nil {
            log.error("Vaccine is nil")
            dismiss(animated: true, completion: nil)
        }
    }

}

extension VaccineDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.keyValue.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        return cell
    }
}
