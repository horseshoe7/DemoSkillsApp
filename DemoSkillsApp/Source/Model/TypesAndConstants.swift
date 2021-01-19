//
//  TypesAndConstants.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import Foundation
import UIKit

let appID = "MY_UNIQUE_APP_ID"

class User {
    
    static var current = User()
    
    var name: String = "Test User"
    
    var deviceID: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    var username: String {
        return "User 007"
    }
    
    var password: String {
        return "pF$$w0rD!"
    }
}
