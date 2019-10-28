//
//  CharacterDetailViewController.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeSexLabel: UILabel!
    @IBOutlet weak var employeeDOBLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: EmployeeDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.employeeDelegate = self
        setupScreen()
        viewModel?.fetchEmployerDetail()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.stopAnimating()
    }

    func setupScreen() {
        title = viewModel?.title
    }

    func displayEmployeeInfo() {
        employeeNameLabel.text = viewModel?.employeeName
        employeeSexLabel.text = viewModel?.employeeSex
        employeeDOBLabel.text = viewModel?.employeeDOB
        employeeImage.image = viewModel?.employeePhoto
    }
}
extension EmployeeDetailViewController: MeBankViewControllerProtocol {
    static var viewName: String {
        return String(describing: self)
    }
}
extension EmployeeDetailViewController: EmployeeDelegate {
    func updateInterface(_ status: Status) {
        switch status {
        case .success:
            displayEmployeeInfo()
        case .error:
            NSLog("(Invalid Response: \(status)")
        }
    }
}
