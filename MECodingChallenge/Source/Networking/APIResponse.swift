//
//  APIResponse.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation

/// Represents an api response
/// - success: success with associated object of Generic type
/// - error: error associated with `APIError` object
enum APIResponse<RESULT> {
  case success(RESULT)
  case error(APIError)
}

extension APIResponse: Equatable where RESULT: Equatable {}
