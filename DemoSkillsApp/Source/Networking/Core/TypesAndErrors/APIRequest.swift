//
//  APIRequest.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation

public protocol APIRequest {
    
    /// Generally used when you configure for your backend environment
    var baseURL: URL { get }
    
    /// if the backend environment changes, the paths probably shouldn't, so we separate these two properties
    var path: String { get }
    
    /// indicates what this response should expect as a data type to parse from the response
    var responseDataType: Decodable.Type? { get }
    
    /// "GET", "POST", etc.  Could also make an enum instead of String...
    var httpMethod: String { get }
    
    /// we presume that the user wants the same language for the whole experience, hence a static var
    static var preferredLanguage: String { get }
    
    /// i.e. what parameters go into your JSON request
    var httpBody: [String: Any]? { get }
    
    /// Generally used for GET requests, you can also put your request parameters in here
    var queryItems: [URLQueryItem]? { get }
    
    /// i.e. accept, content type, user agent, etc. that tend to be application-wide
    /// but can also be configured for each endpoint as required
    var defaultHeaders: [String: String] { get }
    
    /// this test API is condensed but we should make allowances for some kind of auth mechanism in the API
    func urlRequest(authToken: String?) -> URLRequest
}
