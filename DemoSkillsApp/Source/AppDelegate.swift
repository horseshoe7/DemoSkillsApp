//
//  AppDelegate.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import UIKit

// normally here you'd have a @UIApplicationMain declaration
// but we removed this in favour of a main.swift file, which allows
// us to set which AppDelegate to use at runtime.
// we do this so that we can use a barebones delegate for Unit Testing.
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _ = log // initialize log
        print("Starting...")
        
        
        configureServerMocking()
        
        // because we forego the @UIApplicationMain specifier, we have to manually create a window and its rootViewController
        // we forego that because we use the AppDelegateForTesting approach in order to speed up the running of unit tests
        // and to not have to have a "fat test host" for unit tests.
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Main is the name of storyboard
        window = UIWindow()
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureServerMocking() {
        ServerMock.initialize(enabled: true, baseURLString: API.baseURLString)  // NEVER CHANGE THIS
    }
}


// MARK: -- Testing

class AppDelegateForTesting: NSObject, UIApplicationDelegate {

    override init() {
        super.init()
        writeTestLog()
    }

    private func writeTestLog() {
        log.info("Started running tests using an AppDelegateForTesting.")
    }
}
