//
//  ServerDataApi.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
protocol ServerDataAPI {
func fetchEmployeers(completion: @escaping (APIResponse<[Employee]>) -> Void)

func fetch(forEmploymentId id: Int, completion: @escaping (APIResponse<Employee>) -> Void)
}
