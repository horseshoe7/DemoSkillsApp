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
     "session": {
         "logo_base_url": "https://logos.zattic.com/logos",
         "vod_providers": [],
         "start_page_public_id": null,
         "privacy_policy": "http://zattoo.com/company/privacy/",
         "ad_skip_time": -1,
         "image_base_url": "https://images.zattic.com/cms-staging",
         "max_signup_birthdate": "2004-12-10",
         "aliased_country_code": "DE",
         "power_guide_hash": "dd9a48e951b87d2e43e4d5edf47e2bbc",
         "recording_eligible": false,
         "ads_allowed": true,
         "loggedin": false,
         "vod_page_public_id": null,
         "active": true,
         "general_terms": "http://zattoo.com/company/terms/",
         "block_size": 3,
         "broadcast_page_public_id": "zattoo_broadcast_de",
         "current_time": "2020-12-10T16:12:23Z",
         "lineup_hash": "LU8a49e46f7b147731badecd289651904f",
         "language": "en",
         "tracking_urls": [],
         "channel_page_public_id": null,
         "recordings_page_public_id": null,
         "ppid": "47a7e871534ddca5737812eddc1de597734878e5",
         "html5_streaming": false
     },
     "success": true
 }
 
 
 */
