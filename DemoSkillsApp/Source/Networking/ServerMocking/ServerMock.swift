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
    
    static func initialize(sessionConfiguration: URLSessionConfiguration?, baseURLString: String = API.baseURLString) {
        
        baseURL = URL(string: baseURLString)!
        
        if let sessionConfig = sessionConfiguration {
            
            sessionConfig.urlCache = nil
            
            // this method call works because we create our Alamofire.SessionManager with the default URLSessionConfiguration
            // see APIController.swift (154) or the 'sessionManager()' method.
            OHHTTPStubs.setEnabled(true, for: sessionConfig)
            
            log.info("\n\n\n++++++++++++++++++++++++++++++++++++++++++++++++\n\n SERVER MOCK RESPONSES ENABLED!! \nYOU CAN SET THIS IN THE AppDelegate\n\n++++++++++++++++++++++++++++++++++++++++++++++++\n\n\n")
            
            mockStartSession()
            mockLogin()
            mockChannelList()
            mockWatchChannel()
            mockStopWatching()
            mockEndSession()
            
        } else {
            OHHTTPStubs.setEnabled(false)
        }
    }
    
    private static func mockStartSession() {
        
        let filename = "MockSessionChange"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockLogin() {
        
        let filename = "MockEmpty"
        let endpoint = DemoAPIRequest.login(username: "FAKE", password: "IRRELEVANT")
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockChannelList() {
        
        let filename = "MockChannelList"
        let endpoint = DemoAPIRequest.getChannels
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockWatchChannel() {
        
        let filename = "MockWatchChannel"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    
    }
    
    private static func mockStopWatching() {
        
        let filename = "MockEmpty"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func mockEndSession() {
        
        let filename = "MockSessionChange"
        let endpoint = DemoAPIRequest.startSession(appID: appID, deviceID: User.current.deviceID)
        self.stubEndpoint(endpoint, withJson: filename)
    }
    
    private static func stubEndpoint(_ endpoint: APIRequest, withJson responseFilename: String, responseTime: TimeInterval? = 1.2) {
        
        stub(condition: isHost(baseURL.host!) && isPath(endpoint.path)) { (_) -> OHHTTPStubsResponse in
            let filePath = Bundle.main.path(forResource: responseFilename, ofType: "json")!
            
            let response = OHHTTPStubsResponse(fileAtPath: filePath,
                                               statusCode: 200,
                                               headers: ["Content-Type": "application/json"])
            if let responseTime = responseTime {
                response.responseTime = responseTime
            }
            return response
        }
    }
    
}
