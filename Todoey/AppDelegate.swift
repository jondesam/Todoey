//
//  AppDelegate.swift
//  Todoey
//
//  Created by MyMac on 2018-12-22.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
    
        
        do {
            //let realm = try Realm()
            _ = try Realm()
        
        } catch {
            print("Error installing new realm \(error)")
        }
        
        print("didFinishLaunchingWithOptions")
        return true
    }


    
    func applicationWillTerminate(_ application: UIApplication) {
        
         print("applicationWillTerminate")
    //    self.saveContext()
    
    }
    
 
    
    
    // MARK: - Core Data stack
    
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    // MARK: - Core Data Saving support
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

