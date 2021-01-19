//
//  ServerMock.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import Foundation
import OHHTTPStubs

class ServerMock {
    
    static var baseURL: URL = URL(string: API.baseURLString)!
    
    static func initialize(enabled: Bool = true, baseURLString: String = API.baseURLString) {
        
        baseURL = URL(string: baseURLString)!
        
        if enabled {
            
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.urlCache = nil
            
            // this method call works because we create our Alamofire.SessionManager with the default URLSessionConfiguration
            // see APIController.swift (154) or the 'sessionManager()' method.
            OHHTTPStubs.setEnabled(true, for: sessionConfig)
            
            log.info("\n\n\n++++++++++++++++++++++++++++++++++++++++++++++++\n\n SERVER MOCK RESPONSES ENABLED!! \nYOU CAN SET THIS IN THE AppDelegate\n\n++++++++++++++++++++++++++++++++++++++++++++++++\n\n\n")
            
            mockStartSession()
            mockLogin()
            mockWatchChannel()
            mockStopWatching()
            mockEndSession()
            
        } else {
            OHHTTPStubs.setEnabled(false)
        }
    }
    
    private static func mockStartSession() {
        
        let filename = "MockStartSession"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockLogin() {
        
        let filename = "MockLogin"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockWatchChannel() {
        
        let filename = "MockWatchChannel"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    
    }
    
    private static func mockStopWatching() {
        
        let filename = "MockStopWatching"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockEndSession() {
        
        let filename = "MockEndSession"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func stubEndpoint(_ endpoint: APIRequest, withJson responseFilename: String) {
        
        stub(condition: isHost(baseURL.host!) && isPath(endpoint.path)) { (_) -> OHHTTPStubsResponse in
            let filePath = Bundle.main.path(forResource: responseFilename, ofType: "json")!
            return OHHTTPStubsResponse(fileAtPath: filePath,
                                       statusCode: 200,
                                       headers: ["Content-Type": "application/json"])
        }
    }
    
}
