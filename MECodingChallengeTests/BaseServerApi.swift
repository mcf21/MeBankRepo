//
//  BaseServerApi.swift
//  MECodingChallengeTests
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
@testable import MECodingChallenge

class BaseServerDataAPI: ServerDataAPI {
    func fetchEmployeers(completion: @escaping (APIResponse<[Employee]>) -> Void) {
        fatalError("Subclass needs to implement this")
    }

    func fetch(forEmploymentId id: Int, completion: @escaping (APIResponse<Employee>) -> Void) {
        fatalError("Subclass needs to implement this")
    }
}
