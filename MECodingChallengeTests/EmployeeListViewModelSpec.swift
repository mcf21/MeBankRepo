//
//  EmployeeListViewModelSpec.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//
import Foundation
import Nimble
import Quick
@testable import MECodingChallenge

class EmployeeListViewModelSpec: QuickSpec {
    override func spec() {
        describe("Fetch EmployeeList") {
            var employeeListViewModel: EmployeeListViewModel?
            let mockDelegate = MockEmployeeDelegate()
            context("when retrieving a list of employeers") {
                beforeEach {
                    employeeListViewModel = EmployeeListViewModel(networkManager: SuccessfulResponseEmploymentNetworkManager())
                    employeeListViewModel?.employeeDelegate = mockDelegate
                }
                it("will have a successful response and the number of Employees should be 2") {
                    employeeListViewModel?.fetchEmployees()
                    expect(employeeListViewModel?.employerCount).to(equal(2))
                    expect(employeeListViewModel?.employees?[0].firstName).to(equal("test"))
                    expect(employeeListViewModel?.employees?[0].image).to(beNil())
                    expect(employeeListViewModel?.employees?[1].firstName).to(equal("marcus"))
                    expect(employeeListViewModel?.employees?[1].thumbImage).to(equal("thumb"))
                    expect(employeeListViewModel?.employees?[1].lastnameFirst).to(equal("jenson, marcus"))
                    expect(mockDelegate.status).to(equal(.success))
                }
            }
            context("When Rerieving a list of employeers") {
                let mockDelegate = MockEmployeeDelegate()
                beforeEach {
                    employeeListViewModel = EmployeeListViewModel(networkManager: InvalidEmploymentResonse())
                    employeeListViewModel?.employeeDelegate = mockDelegate
                }
                it("will have a Uncesssful stataussuccessful response and there should be 0 employers in the employerCount") {
                    employeeListViewModel?.fetchEmployees()
                    expect(employeeListViewModel?.employerCount) == 0
                    expect(mockDelegate.status) == .error
                }
            }
        }
    }
}
final class InvalidEmploymentResonse: BaseServerDataAPI {
  override func fetchEmployeers(completion: @escaping (APIResponse<[Employee]>) -> Void) {
    completion(.error(APIError(type: .notFound)))
  }
}
fileprivate final class SuccessfulResponseEmploymentNetworkManager: BaseServerDataAPI {
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
