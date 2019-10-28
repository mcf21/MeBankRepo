//
//  NetworkManager+Employment.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
extension NetworkManager: ServerDataAPI {
    func fetchEmployeers(completion: @escaping (APIResponse<[Employee]>) -> Void) {
        let request = EmploymentRequest(withNetworkManager: self)
        perform(request, completion: completion)
    }

    func fetch(forEmploymentId id: Int, completion: @escaping (APIResponse<Employee>) -> Void) {
        let request = EmploymentDetailRequest(employeeId: id, networkManager: self)
        perform(request, completion: completion)
    }
}
