//
//  Employee.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

//Employee is a model obejct that represents the employees for a company.
// MARK: - Employee
struct EmployeeJSONKey {
    fileprivate static let id = "id"
    fileprivate static let firstName = "first_name"
    fileprivate static let lastName = "last_name"
    fileprivate static let gender = "gender"
    fileprivate static let birthDate = "birth_date"
    fileprivate static let thumbImage = "thumbImage"
    fileprivate static let image = "image"
}
struct Employee: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var gender: String
    var birthDate: String
    var thumbImage: String?
    var image: String?
}
extension Employee {
    var lastnameFirst: String {
        return "\(lastName) , \(firstName)"
    }

    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
extension Employee: JSONDeserializable {
  static func fromJSON(_ json: JSON) -> Employee? {
    guard let id = json[EmployeeJSONKey.id].int, let firstName = json[EmployeeJSONKey.firstName].string,
        let lastName = json[EmployeeJSONKey.lastName].string, let gender = json[EmployeeJSONKey.gender].string, let birthDate = json[EmployeeJSONKey.birthDate].string else {
      return nil
    }
    let thumbImage = json[EmployeeJSONKey.image].string
    let bigImage = json[EmployeeJSONKey.image].string
    return Employee(id: id, firstName: firstName, lastName: lastName, gender: gender, birthDate: birthDate,
                    thumbImage: thumbImage, image: bigImage)
  }
}
