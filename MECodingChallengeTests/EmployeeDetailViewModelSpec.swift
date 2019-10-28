//
//  EmployeeDetailViewModelSpec.swift
//  MECodingChallengeTests
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import MECodingChallenge

class EmployeeDetailViewModelSpec: QuickSpec {
    override func spec() {
        describe("Fetch Employee") {
            var employerDetailViewModel: EmployeeDetailViewModel?
            let mockDelegate = MockEmployeeDelegate()
            context("when retrieving employerdetails") {
                beforeEach {
                    employerDetailViewModel = EmployeeDetailViewModel(employeeId: 1, network: SuccessfulResponseEmployeerDetailNetworkManager())
                    employerDetailViewModel?.employeeDelegate = mockDelegate
                }
                it("will have a successful response and valid Employeer Detailed Info") {
                    employerDetailViewModel?.fetchEmployerDetail()
                    expect(employerDetailViewModel?.employeeDOB).to(equal("25/12/2019"))
                    expect(employerDetailViewModel?.employeeSex).to(equal("Male"))
                    expect(employerDetailViewModel?.employeeName).to(equal("Ted Bear"))
                    expect(mockDelegate.status).to(equal(.success))
                }
            }
            context("When Rerieving a employee Detail for a specific employer elements will be missing") {
                let mockDelegate = MockEmployeeDelegate()
                beforeEach {
                    employerDetailViewModel = EmployeeDetailViewModel(employeeId: 1, network: InvalidEmploymentDetailResonse())
                    employerDetailViewModel?.employeeDelegate = mockDelegate
                }
                it("will display an error message indicating the field was not found.") {
                    employerDetailViewModel?.fetchEmployerDetail()
                    expect(employerDetailViewModel?.employeeDOB).to(equal("Birtday not Found"))
                    expect(employerDetailViewModel?.employeeSex).to(equal("Gender not Found"))
                    expect(employerDetailViewModel?.employeeName).to(equal("Name Not Found"))
                    expect(employerDetailViewModel?.employeePhoto).to(beNil())
                    expect(mockDelegate.status) == .error
                }
            }
        }
    }
}
private final class InvalidEmploymentDetailResonse: BaseServerDataAPI {
    override func fetch(forEmploymentId id: Int, completion: @escaping (APIResponse<Employee>) -> Void) {
        completion(.error(APIError(type: .notFound)))
    }
}
fileprivate final class SuccessfulResponseEmployeerDetailNetworkManager: BaseServerDataAPI {
    override func fetchEmployeers(completion: @escaping (APIResponse<[Employee]>) -> Void) {
        let employees = [Employee(id: 1, firstName: "test", lastName: "lastTest", gender: "male", birthDate: "02/16/1977", thumbImage: "lkdfadf", image: nil),Employee(id: 1, firstName: "marcus", lastName: "jenson", gender: "male", birthDate: "1/2/2000", thumbImage: "thumb", image: nil)]
        completion(.success(employees))
    }

    override func fetch(forEmploymentId id: Int, completion: @escaping (APIResponse<Employee>) -> Void) {
        let employee = Employee(id: 1, firstName: "Ted", lastName: "Bear", gender: "Male", birthDate: "25/12/2019", thumbImage: "lkdfadf", image: "lkjfasfad")
        completion(.success(employee))
    }
}
fileprivate final class MockEmployeeDelegate: EmployeeDelegate {
    private(set) var status: Status?
    func updateInterface(_ status: Status) {
        self.status = status
    }
}

