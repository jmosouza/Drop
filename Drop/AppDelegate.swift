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
            let context = persistentContainer.viewContext
            
            for vaccine in vaccines {
                let v = VaccineMO(context: context)
                v.title = vaccine.title
                v.recordedDate = vaccine.recordedDate as NSDate?
                v.estimatedDate = vaccine.estimatedDate as NSDate?
            }
            
            do {
                log.debug(context.hasChanges)
                log.debug(context.insertedObjects)
                try context.save()
            } catch {
                log.severe(error)
            }
            
        }

        return true
    }
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Drop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



}
