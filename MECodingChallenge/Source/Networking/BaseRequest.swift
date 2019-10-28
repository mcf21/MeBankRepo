//
//  BaseRequest.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Base class for requests
class BaseRequest {

  var networkManager: NetworkManager

  init(withNetworkManager networkManager: NetworkManager) {
    self.networkManager = networkManager
  }

  // This is the request method that subclasses should overwrite.
  // It will need to pick what actual request to call, .POST/.GET etc.
  func requestMethod() -> Alamofire.HTTPMethod {
    assert(false, "This method must be overridden by the subclass")
    return Alamofire.HTTPMethod.post
  }

  // The separation between request() and performRequest() is that if a child class
  // needs to override the request functionality it should do it here.
  // performRequest() should not contain request specific code, rather global request code only.
  func request(_ completionHandler: @escaping (NetworkResponse) -> Void) {
    performRequest(completionHandler)
  }

  // Simply makes a basic request and feeds data back to calling request.
  // This request will automatically differentiate generic errors.
  // So derived requests only need to focus on their specific error cases.
  func performRequest(_ completionHandler: @escaping (NetworkResponse) -> Void) {
    // These are separated into values simply for debugging purposes.
    let requestUrl = requestURL()
    let requestParams = parameters()
    let requestHeaders = HTTPHeaders()

    NetworkManager.manager.request(requestUrl,
                                   method: requestMethod(),
                                   parameters: requestParams,
                                   encoding: encoding(),
                                   headers: requestHeaders)
      .validate() // validate guarantees correct HTTP error codes are observed...
      .responseData { response in

        switch response.result {
        case .success(let data):
          if let json = try? JSON(data: data) {
            completionHandler(.success(json, response.response?.allHeaderFields))
          } else {
            completionHandler(.success(JSON.null, response.response?.allHeaderFields))
          }
        case .failure( _ ):

          var errorType = APIErrorType.notFound

          if let data = response.data, let jsonDict = try? JSON(data: data).dictionaryValue {
            let errorTypeInt = jsonDict["ErrorType"]?.intValue ?? -1
            if let correctErrorType = APIErrorType(rawValue: errorTypeInt) {
              NSLog("[BaseRequest] errorType:\(correctErrorType.rawValue)")
              errorType = correctErrorType
            }
          }

          completionHandler(.error(APIError(type: errorType)))
        }
    }
  }

  // Derived request should override this to set the request URL
  func requestURL() -> URLConvertible {
    assert(false, "This method must be overridden by the subclass")
    return "no_url"
  }

  // Derived request should override this to set the unique headers,
  // however it can be left alone for default headers
  func headers() -> [String: String] {
    return networkManager.defaultHeaders()
  }

  // Override to pass parameters to request
  func parameters() -> [String: Any]? {
    return nil
  }

  func encoding() -> ParameterEncoding {
    return URLEncoding()
  }

}
