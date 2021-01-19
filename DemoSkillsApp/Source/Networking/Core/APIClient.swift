//
//  APIClient.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 10.12.20.

//

import Foundation


public protocol RequestSending {
    
    // use this method for a request that you require parsed data from.
    @discardableResult func sendRequestAndDecodeJSON<T: Codable>(_ apiRequest: APIRequest, completion: @escaping (APIResult<T>) -> Void) -> URLSessionTask?
    
    // use this method for requests where just the response status code is enough.
    @discardableResult func sendRequest(_ apiRequest: APIRequest, completion: @escaping (EmptyAPIResult) -> Void) -> URLSessionTask?
}


public class APIClient: RequestSending {
    
    public static let shared = APIClient()
    
    lazy var session: URLSession = {
        
        let queue = OperationQueue()
        //queue.maxConcurrentOperationCount = 4  // configure for connectivity, i.e. wifi, cellular, etc.
        
        var configuration = URLSessionConfiguration.default
        configuration.multipathServiceType = .handover
        
        let session = URLSession(configuration: .default,
                                 delegate: nil,
                                 delegateQueue: queue)
        
        return session
    }()
    
    /// For endpoints where you expect response data
    /// Completes on the Main Thread
    @discardableResult
    public func sendRequestAndDecodeJSON<T: Codable>(_ apiRequest: APIRequest,
                                                                 completion: @escaping (APIResult<T>) -> Void) -> URLSessionTask? {
        let urlRequest = apiRequest.urlRequest(authToken: nil)
        log.info("↕️ [APIClient] Sending Request... -> \(apiRequest.httpMethod) \(urlRequest)")
        
        guard apiRequest.responseDataType == T.self else {
            fatalError("Invalid configuration.  The expected type in your APIResult should match the responseDataType of the APIRequest.")
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                guard let data = data else {
                    throw APIClientError.noData
                }
                
                // output requirement:  Print out the content of each response the server sends to the XCode console.
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let url = urlRequest.url {
                    log.debug("[APIClient] \(url.path) Response JSON:\n\(json as NSDictionary)")
                }
                
                if let error = error {
                    throw error
                }
                
                if let httpError = HTTPError(response: response) {
                    throw httpError
                }
                
                let result = try JSONDecoder().decode(T.self, from: data)
                
                // output requirement:  Print out the stream URL returned in the Watch response to the XCode console.
                log.debug("[APIClient] Parsed Response:\n\(String(reflecting: result))\n")
                
                log.info("✅ [APIClient]: \(apiRequest.httpMethod) \(urlRequest)")
                
                // we are using a delegateQueue on URLSession, so we want to complete on the main thread
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch let error {
                log.error("❌ [APIClient]: \(Date()) - \(String(reflecting: error)) - \(urlRequest)")
                
                let clientError: APIClientError
                
                if let e = error as? APIClientError {
                    // maybe there's something of interest here you want to do in particular, like error reporting.
                    log.error("APIClientError: \(e)")
                    clientError = e
                } else if error is DecodingError {
                    clientError = .invalidResponseData
                } else if let httpError = error as? HTTPError {
                    clientError = .http(error: httpError)
                } else {
                    clientError = .unexpected(error: error)
                }
                
                // we are using a delegateQueue on URLSession, so we want to complete on the main thread
                DispatchQueue.main.async {
                    completion(.failure(clientError))
                }
            }
        }
        task.resume()
        return task
    }
    
    /// For endpoints where the response status code is enough.
    /// Completes on the Main Thread
    @discardableResult
    public func sendRequest(_ apiRequest: APIRequest,
                     completion: @escaping (EmptyAPIResult) -> Void) -> URLSessionTask? {
        
        if apiRequest.responseDataType != nil {
            log.info("WARNING: You are making a request that ignores the response data, even though your APIRequest has a defined responseDataType")
        }
        
        let urlRequest = apiRequest.urlRequest(authToken: nil)
        log.info("↕️ [APIClient] Sending Request... -> \(apiRequest.httpMethod) \(urlRequest)")
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
    
                // output requirement:  Print out the content of each response the server sends to the XCode console.
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let url = urlRequest.url {
                    log.debug("[APIClient] \(url.path) Response JSON:\n\(json as NSDictionary)")
                }
    
                if let error = error {
                    throw error
                }
                
                if let httpError = HTTPError(response: response) {
                    throw httpError
                }
                
                log.info("✅ [APIClient]: \(apiRequest.httpMethod) \(urlRequest)")
                DispatchQueue.main.async {
                    completion(.success)
                }

            } catch let error {
                log.error("❌ [APIClient]: \(Date()) - \(error.localizedDescription) - \(urlRequest)")
                
                let clientError: APIClientError
                
                if let e = error as? APIClientError {
                    // maybe there's something of interest here you want to do in particular, like error reporting.
                    log.error("APIClientError: \(e)")
                    clientError = e
                } else if let httpError = error as? HTTPError {
                    clientError = .http(error: httpError)
                } else {
                    clientError = .unexpected(error: error)
                }
                
                DispatchQueue.main.async {
                    completion(.failure(clientError))
                }
            }
        }
        task.resume()
        return task
    }
}
