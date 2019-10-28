//
//  EmploymentDetailRequst.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import Alamofire
//EmploymentDetailRequest class is a component that is responsible for building a request to retrieve EmploymentDetail.
final class EmploymentDetailRequest: BaseRequest {
    fileprivate var employeeId: Int

    init(employeeId: Int, networkManager: NetworkManager) {
      self.employeeId = employeeId
        super.init(withNetworkManager: networkManager)
    }

    override func requestMethod() -> Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod.get
    }

    override func requestURL() -> URLConvertible {
        return "\(EndpointConfig.sharedInstance.endpoint.baseURL)\(APIConstants.CategoryPath.employees)/\(employeeId)"
    }
}

