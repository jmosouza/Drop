//
//  VaccineManager.swift
//  Drop
//
//  Created by João Marcelo on 05/03/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit
import CoreData

class VaccineManager {
    
    static let shared = VaccineManager()
    
    private let coreDataManager: CoreDataManager = .shared
    
    func vaccines() -> [Vaccine]? {
        do {
            // Fetch from local store
            let context = coreDataManager.persistentContainer.viewContext
            let request = Vaccine.fetchRequest() as NSFetchRequest<Vaccine>
            return try context.fetch(request)
        } catch {
            log.severe(error)
            return nil
        }
    }
    
}
