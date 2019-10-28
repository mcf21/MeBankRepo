//
//  APIError.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
private enum APIErrorKey: String {
  case code = "status"
  case description = "message"
}

enum APIErrorType: Int {
  case parsingError = 2
  case notFound = 404 //NOT Found Request
}

struct APIError: Error, Equatable {
  let type: APIErrorType
  var code: Int?
  var description: String?
  init(type: APIErrorType, code: Int? = 0, description: String? = nil) {
    self.type = type
    self.code = code
    self.description = description
  }
}
