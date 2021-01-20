//
//  DemoAPIRequest.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation

public struct API {
    static let baseURLString: String = "https://my-non-existent-url.com"
}


/// The Endpoints we have available in the sandbox server
public enum DemoAPIRequest {
    
    case startSession(appID: String, deviceID: String)
    case login(username: String, password: String)
    case getChannels
    case watchChannel(channelID: String)
    case stopChannel
    case stopSession
}

extension DemoAPIRequest: APIRequest {
    
    public var baseURL: URL {
        return URL(string: API.baseURLString)!
    }
    
    public var path: String {
        switch self {
        case .startSession:
            return "/session/start"
        case .login:
            return "/login"
        case .getChannels:
            return "/channels"
        case .watchChannel:
            return "/watch"
        case .stopChannel:
            return "/stop"
        case .stopSession:
            return "/session/goodbye"
        }
    }
    
    // this doesn't really get used right now, just for checking for coding errors
    // but tells the coder what type of response to expect for a given endpoint
    public var responseDataType: Decodable.Type? {
        switch self {
        case .startSession, .stopSession:
            return SessionChangeResponse.self
        case .watchChannel:
            return WatchChannelResponse.self
        case .stopChannel, .login:
            return nil
        case .getChannels:
            return ChannelListResponse.self
        }
    }
    
    public static var preferredLanguage: String {
        // sometimes you get things like de-DE, or de-AT, or en-GB, etc.
        // and we just want the language without the region aspect of that language
        return Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "en"
    }
    
    
    public var httpBody: [String: Any]? {
        
        // NOTE:  I left this commented out because I'd argue that httpBody is used for sending POST/PATCH params,
        // and query params are used for GET requests...
        
        switch self {
        case .startSession(let appID, let deviceID):
            return ["app_tid": appID, "uuid": deviceID, "lang": DemoAPIRequest.preferredLanguage, "format": "json"]
        case .login(let username, let password):
            return ["login": username, "password": password]
        case .watchChannel(let channelID):
            return ["cid": channelID, "stream_type": "hls"]
        default:
            return nil
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        return nil
    }
    
    public var httpMethod: String {
        switch self  {
        case .startSession, .login, .watchChannel, .stopSession, .stopChannel:
            return "POST"
        case .getChannels:
            return "GET"
        }
    }
    
    public var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        switch self {
        default:
            headers["Content-Type"] = "application/json; charset=utf-8"
            headers["Accept"] = "application/json; charset=utf-8"
            headers["Accept-Encoding"] = "gzip"
        }

        return headers
    }
    
    public func urlRequest(authToken: String? = nil) -> URLRequest {
        let endpointURL = baseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = httpMethod
        if let body = httpBody, let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) {
            urlRequest.httpBody = bodyData
        }

        urlRequest.allHTTPHeaderFields = defaultHeaders

        return urlRequest
    }
}
