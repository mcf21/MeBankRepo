//
//  EmployeeListViewModel.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
class EmployeeListViewModel  {
    // MARK: - Attributes
    fileprivate let zeroEmployees: Int = 0
    private var listOfEmployees: [Employee]?
    var employeeDelegate: EmployeeDelegate?

    // MARK: - Initializers
    fileprivate let networkManager: ServerDataAPI

    init(networkManager: ServerDataAPI = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchEmployees() {
        networkManager.fetchEmployeers { [weak self] (employees) in
            switch employees {
            case .success(let employeeList):
                self?.listOfEmployees = employeeList
                self?.employeeDelegate?.updateInterface(.success)
            case .error(_ ):
                self?.employeeDelegate?.updateInterface(.error)
            }
        }
    }
}
extension EmployeeListViewModel {
    var employees: [Employee]? {
        guard let employees = listOfEmployees else { return nil }
        return employees
    }
    var employerCount: Int {
        return listOfEmployees?.count ?? zeroEmployees
    }

    var title: String {
        return "PEOPLE.DB.TITLE".localized
    }
}
