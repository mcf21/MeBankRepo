//
//  NeworkResponse.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import SwiftyJSON

enum NetworkResponse: Error {

  // Success
  case success(JSON, [AnyHashable: Any]?)

  // General network error
  case error(APIError)

  // Helper method to get a readable description of the error.
  var description: String {
    switch self {
    case .success:
      return "Success"
    case .error(let error):
      return String(format: "Sorry, the server isn’t playing nice. Error code %d.", error.code ?? 0)
    }
  }
}
