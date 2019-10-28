//
//  ViewController.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {


    @IBOutlet weak var employeeTableView: UITableView!

    var viewModel: EmployeeListViewModel = EmployeeListViewModel(networkManager: NetworkManager())

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.employeeDelegate = self
        configureView()
        fetchEmployees()
    }

    override func viewWillAppear(_ animated: Bool) {
        employeeTableView.reloadData()
    }

    func fetchEmployees() {
        viewModel.fetchEmployees()
    }

    func configureView() {
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        let nib = UINib(nibName: EmployeesTableViewCell.nibName, bundle: Bundle.main)
        employeeTableView.register(nib, forCellReuseIdentifier: EmployeesTableViewCell.reuseIdentifier)
        title = viewModel.title
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.reuseIdentifier, for: indexPath) as! EmployeesTableViewCell
        guard let employee = viewModel.employees?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(forEmployee: employee)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employerCount
    }
}

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let employeeDetailViewController = storyboard?.instantiateViewController(withIdentifier:   EmployeeDetailViewController.viewName)
            as? EmployeeDetailViewController, let employee = viewModel.employees?[indexPath.row] else { return }
        let viewModel = EmployeeDetailViewModel(employeeId: employee.id)
        employeeDetailViewController.viewModel = viewModel
        navigationController?.pushViewController(employeeDetailViewController, animated: true)
        employeeTableView.deselectRow(at: indexPath, animated: false)
    }
}

extension EmployeeListViewController: MeBankViewControllerProtocol {
    static var viewName: String {
        return String(describing: self)
    }
}

extension EmployeeListViewController: EmployeeDelegate {
    func updateInterface(_ status: Status) {
        switch status {
        case .success:
            self.employeeTableView.reloadData()
        case .error:
            NSLog("(Invalid Response: \(status)")
        }
    }
}
