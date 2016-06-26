//
//  AppDelegate.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let stack = CoreDataStack(modelName: "Model")!
    
    func preloadData(){
        
        // Remove previous stuff (if any)
        do{
            try stack.dropAllData()
        }catch{
            print("Error droping all objects in DB")
        }
        
        let articleONE = Article(articleTitle: "the new article", context: stack.context)
        let articleTwo = Article(articleTitle: "the second article", context: stack.context)
        
        
        print(articleONE)
        print(articleTwo)
        
    }
    
    func backgroundLoad(){
        
        stack.performBackgroundBatchOperation { (workerContext) in
            
            
            for i in 1...100{
                _ = Article(articleTitle: "Background Article \(i)", context: workerContext)
            }
            print("==== finished background operation ====")
            
        }
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        preloadData()

        // Start Autosaving
        stack.autoSave(2)
        
        // add new objects in the background
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(5 * NSEC_PER_SEC)), dispatch_get_main_queue()){
            self.backgroundLoad()
        }
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        stack.save()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        stack.save()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //stack.save()
    }




}

