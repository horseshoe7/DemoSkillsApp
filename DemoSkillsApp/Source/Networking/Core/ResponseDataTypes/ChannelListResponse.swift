//
//  ChannelListResponse.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import Foundation

fileprivate let dateFormatter: ISO8601DateFormatter = {
    let iso = ISO8601DateFormatter()
    return iso
}()

public struct ChannelListItem: Codable {
    public let name: String
    public let channelDescription: String
    public let channelID: String
    public let thumbnailURL: URL?
    public let lastWatchedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case channelDescription = "description"
        case channelID = "cid"
        case lastWatchedAt = "last_watched_at"
        case thumbnailURL = "thumb_url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        channelDescription = try values.decode(String.self, forKey: .channelDescription)
        channelID = try values.decode(String.self, forKey: .channelID)
        if let dateString = try values.decodeIfPresent(String.self, forKey: .lastWatchedAt) {
            lastWatchedAt = dateFormatter.date(from: dateString)
        } else {
            lastWatchedAt = nil
        }
        if let urlString = try values.decodeIfPresent(String.self, forKey: .thumbnailURL) {
            thumbnailURL = URL(string: urlString)
        } else {
            thumbnailURL = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(thumbnailURL, forKey: .thumbnailURL)
        try container.encode(name, forKey: .name)
        try container.encode(channelDescription, forKey: .channelDescription)
        try container.encode(channelID, forKey: .channelID)
        
        if let lastWatched = lastWatchedAt {
            let string = dateFormatter.string(from: lastWatched)
            try container.encode(string, forKey: .lastWatchedAt)
        }
    }
    
    public var debugDescription: String {
        return "ChannelListItem: \(name)\nid: \(channelID)\ndesc: \(channelDescription)\nurl: \(thumbnailURL?.absoluteString ?? "(none)")"
    }
}

public struct ChannelListResponse: Codable, CustomDebugStringConvertible {
    
    public let channelList: [ChannelListItem]
    
    enum CodingKeys: String, CodingKey {
        case channelList = "channels"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channelList = try values.decode([ChannelListItem].self, forKey: .channelList)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channelList, forKey: .channelList)
    }
    
    public var debugDescription: String {
        return "ChannelListResponse: \(channelList)"
    }
}
