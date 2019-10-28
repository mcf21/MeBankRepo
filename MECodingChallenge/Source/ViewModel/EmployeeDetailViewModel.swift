//
//  EmployeeDetailViewModel.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import UIKit

class EmployeeDetailViewModel {
    fileprivate var employee: Employee?
    let employeeId: Int
    let networkManager: ServerDataAPI
    var employeeDelegate: EmployeeDelegate?

    init(employeeId: Int, network: ServerDataAPI = NetworkManager()) {
        networkManager = network
        self.employeeId = employeeId
    }

    func fetchEmployerDetail() {
        networkManager.fetch(forEmploymentId: employeeId) { [weak self] (employee) in
            switch employee {
            case .success(let employee):
                self?.employee = employee
                self?.employeeDelegate?.updateInterface(.success)
            case .error(_ ):
                self?.employeeDelegate?.updateInterface(.error)
            }
        }
    }

    var employeePhoto: UIImage? {
        guard let imageString = employee?.image,
            let dataDecoded : Data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters),
            let decodedimage = UIImage(data: dataDecoded) else { return nil }
        return decodedimage
    }

    var employeeName: String {
        guard let fullName = employee?.fullName else { return "NAME.NOT.FOUND".localized }
        return fullName
    }

    var employeeSex: String {
        guard let gender = employee?.gender else { return "GENDER.NOT.FOUND".localized }
        return gender
    }

    var employeeDOB: String {
        guard let birthday = employee?.birthDate else { return "BIRTHDAY.NOT.FOUND".localized }
        return birthday
    }
    var title: String {
        return "PERSON.DETAIL".localized
    }
}
