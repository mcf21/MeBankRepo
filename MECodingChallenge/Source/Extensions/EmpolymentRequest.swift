//
//  EmpolymentRequest.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import Alamofire
//EmploymentRequest class is a component that is responsible for building a request to retrieve the employment list.
final class EmploymentRequest: BaseRequest {
  override func requestMethod() -> Alamofire.HTTPMethod {
    return Alamofire.HTTPMethod.get
  }

  override func requestURL() -> URLConvertible {
    return "\(EndpointConfig.sharedInstance.endpoint.baseURL)\(APIConstants.CategoryPath.employees)"
  }
}
