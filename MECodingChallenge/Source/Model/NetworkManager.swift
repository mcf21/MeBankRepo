//
//  NetworkManager.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Networking manager is responsible for executing request to the API's.  Th
class NetworkManager {
    static var manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.urlCache = nil
        return Alamofire.Session(configuration: configuration)
    }()

  func defaultHeaders() -> [String: String] {
    return [:]
  }
}

extension NetworkManager {
  /**
   Perform a request where the response is a JSONDeserializable object.  This generic function will be used when a object of type APIResponse is returned.
   when performing a request.
   */
  func perform<T: JSONDeserializable>(_ request: BaseRequest, key: String? = nil, completion: @escaping (APIResponse<T>) -> Void) {
    request.request { response in
      switch response {
      case .success(let json, _):
        guard let model = T.fromJSON(json[key]) else {
          return completion(.error(APIError(type: .parsingError)))
        }
        completion(.success(model))
      case .error(let error):
        completion(.error(error))
      }
    }
  }

  /**
   Perform a request where the response is an Array of JSONDeserializable objects.  This generic function will be used when
   a collection of type APIResponse objects is returned.
   */
  func perform<T: JSONDeserializable>(_ request: BaseRequest, key: String? = nil, completion: @escaping (APIResponse<[T]>) -> Void) {
    request.request { response in
      switch response {
      case .success(let jsonResponse, _):
        guard let responseArray = jsonResponse[].array else {
          completion(.success([]))
          return
        }
        let models: [T] = responseArray.compactMap { T.fromJSON($0) }
        completion(.success(models))
      case .error(let error):
        completion(.error(error))
      }
    }
  }
}

private extension JSON {
  subscript(_ subscriptKey: String?) -> JSON {
    guard let subscriptKey = subscriptKey else { return self }
    return self[subscriptKey]
  }
}
