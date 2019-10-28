//
//  Endpoint.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
struct Endpoint {
  var baseURL: String

  init(withBaseURL baseURL: String) {
    self.baseURL = baseURL
  }
}
