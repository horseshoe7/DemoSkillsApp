//
//  StartSessionResponse.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation


/// We call it a SessionChangeResponse instead of something like SessionStateResponse because of `success`.  It implies you attempted to change the state of the session, so success denotes whether that change succeeded.
public struct SessionChangeResponse: Codable, CustomDebugStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case success
    }
    
    public let wasSuccessful: Bool
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        wasSuccessful = try values.decode(Bool.self, forKey: .success)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wasSuccessful, forKey: .success)
    }
    
    public var debugDescription: String {
        return "SessionChangeResponse succeeded: \(wasSuccessful)"
    }
}


/*
 Example Response:
 
 {
     "success": true
 }
 
 
 */
