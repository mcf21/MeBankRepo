//
//  JSONSealizable.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONDeserializable {
  static func fromJSON(_ json: JSON) -> Self?
  static func fromJSONArray(_ jsonArray: [JSON]?) -> [Self]?
}

extension JSONDeserializable {
  static func fromJSONArray(_ jsonArray: [JSON]?) -> [Self]? {
    let results = jsonArray?.compactMap { fromJSON($0) }
    return results
  }
}

typealias JSONDictionary = [String: AnyObject]

protocol JSONSerializable {
  func toJSONDictionary() -> JSONDictionary?
}

extension Array where Element: JSONSerializable {
  func toJSON() -> [JSONDictionary] {
    return compactMap { $0.toJSONDictionary() }
  }
}
