//
//  AppDelegate.swift
//  Drop
//
//  Created by João Marcelo on 25/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import CoreData
import UIKit
import XCGLogger

let log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Set up XCGLogger basic usage.
        // https://github.com/DaveWoodCom/XCGLogger#basic-usage-quick-start
        log.setup(
            level: .debug,
            showThreadName: true,
            showLevel: true,
            showFileNames: true,
            showLineNumbers: true,
            fileLevel: .debug)
        
        // First launch
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: K.Flag.isNthLaunch)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: K.Flag.isNthLaunch)
            
            // Initial data
            let vaccines = K.Initial.Vaccines.usaBirthToFifteenMonths_2017_02
            let persistentContainer = CoreDataManager.shared.persistentContainer
            let context = persistentContainer.viewContext
            
            for vaccine in vaccines {
                let newVaccine = Vaccine(context: context)
                newVaccine.title = vaccine.title
                newVaccine.estimatedDate = vaccine.estimatedDate as NSDate?
            }
            
            do {
                try context.save()
            } catch {
                log.severe(error)
            }
            
        }

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }

}
