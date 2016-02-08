//
//  AppDelegate.swift
//  Contacts
//
//  Created by Evghenii Nicolaev on 2/3/16.
//  Copyright © 2016 Endava. All rights reserved.
//

import UIKit
import CoreData
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    #if MVVM
    let container = Container() { container in
        
        // Models
        container.register(ContactMVVM.self) { _ in ContactMVVM() }
        container.register(Avatar.self) { _ in Avatar() }
        
        // View models
        container.register(ContactListViewModelProtocol.self) {r in
            let viewModel = ContactListViewModel()
            viewModel.contactDetailViewModel = r.resolve(ContactDetailsViewModelProtocol.self)!
            return viewModel
        }.inObjectScope(.Container)
        container.register(ContactDetailsViewModelProtocol.self) { _ in
            return ContactDetailsViewModel()
        }.inObjectScope(.Container)
        container.register(AvatarListViewModelProtocol.self) { _ in
            return AvatarListViewModel()
        }

        // Views
        container.registerForStoryboard(ContactListViewController.self) { r, c in
            c.viewModel = r.resolve(ContactListViewModelProtocol.self)!
        }
        container.registerForStoryboard(ContactDetailsViewController.self) { r, c in
            c.viewModel = r.resolve(ContactDetailsViewModelProtocol.self)!
        }
        container.registerForStoryboard(AvatarListViewController.self) { r, c in
            c.viewModel = r.resolve(AvatarListViewModelProtocol.self)!
        }
    }
    #endif


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        #if MVVM
            
            let bundle = NSBundle(forClass: ContactListViewController.self)
            let storyboard = SwinjectStoryboard.create(name: "Main", bundle: bundle, container: container)
            window!.rootViewController = storyboard.instantiateInitialViewController()
            
        #endif
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
    }

}

