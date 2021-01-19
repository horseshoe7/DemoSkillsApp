//
//  HTTPError.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation
/// HTTP Errors modeled after [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)
///
/// - badRequest:                   400
/// - unauthorized:                 401
/// - paymentRequired:              402
/// - forbidden:                    403
/// - notFound:                     404
/// - methodNotAllowed:             405
/// - notAcceptable:                406
/// - proxyAuthenticationRequired:  407
/// - requestTimeout:               408
/// - conflict:                     409
/// - gone:                         410
/// - lengthRequired:               411
/// - preconditionFailed:           412
/// - requestEntityTooLarge:        413
/// - requestURITooLong:            414
/// - unsupportedMediaType:         415
/// - requestedRangeNotSatisfyable: 416
/// - expectationFailed:            417
/// - internalServerError:          500
/// - notImplemented:               501
/// - badGateway:                   502
/// - serviceUnavailable:           503
/// - gatewayTimeout:               504
/// - httpVersionNotSupported:      505

public enum HTTPError: Int, Error {
    
    public init?(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else { return nil }
        self.init(rawValue: response.statusCode)
    }
    
    public init?(httpResponse: HTTPURLResponse?) {
        guard let httpResponse = httpResponse else { return nil }
        self.init(rawValue: httpResponse.statusCode)
    }
    
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfyable = 416
    case expectationFailed = 417
    
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505

    var isBackendFailure: Bool {
        switch rawValue {
        case 500..<600:
            return true
        default:
            return false
        }
    }
}
