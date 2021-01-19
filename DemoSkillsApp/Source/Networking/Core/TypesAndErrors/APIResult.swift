//
//  APIResult.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation

/// the data type returned from an APIRequest
public enum APIResult<T> {
    
    /// When your request returned a 2xx status code and parsed the data of type T
    case success(T)
    
    /// i.e. instead of Swift.Error, we constrain to APIClientError so you can just deal
    /// with those cases and not have to think about every possible error case.
    case failure(APIClientError)
}

public enum EmptyAPIResult {
    
    /// When your request returned a 2xx status code
    case success
    
    /// i.e. instead of Swift.Error, we constrain to APIClientError so you can just deal
    /// with those cases and not have to think about every possible error case.
    case failure(APIClientError)
}


/// This defines the type of error that can be passed to the completion block for any `RequestSending` function.
/// It separates them into clear cases of what could go wrong with any such request.
public enum APIClientError: LocalizedError {
    /// if we expect data and there isn't any
    case noData
    /// i.e. if the json data couldn't be parsed according to the spec.  Basically `DecodingError` will be wrapped into this case
    case invalidResponseData
    
    /// if your request fails because of server-client communication problems.
    case http(error: HTTPError)
    
    /// for any other error that you really couldn't see coming
    case unexpected(error: Swift.Error)
    
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return L10n.APIClientError.noData
        case .invalidResponseData:
            return L10n.APIClientError.invalidResponseData
        case .unexpected(let error):
            return L10n.APIClientError.Unexpected.stringArg(error.localizedDescription)
        case .http(let httpError):
            return L10n.APIClientError.Http.stringArg(httpError.localizedDescription)
        }
    }
}


// There's also the error response model in JSON.  Do I need this?

/*
 {
     "internal_code": 421,
     "http_status": 404,
     "success": false
 }
 */
