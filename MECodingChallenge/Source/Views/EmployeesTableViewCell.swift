//
//  EmployeesTableViewCell.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {
    static let reuseIdentifier = "employeeCell"
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeSexLabel: UILabel!
    @IBOutlet weak var employeeDOBLabel: UILabel!

    func configureCell(forEmployee employee: Employee) {
        if let thumbImage = employee.thumbImage {
            employeeImage.image = createThumnail(using: thumbImage)
        }
        employeeNameLabel.text = employee.lastnameFirst
        employeeDOBLabel.text = employee.birthDate
        employeeSexLabel.text = employee.gender
    }

    fileprivate func createThumnail(using data: String) -> UIImage? {
        guard let dataDecoded : Data = Data(base64Encoded: data, options: .ignoreUnknownCharacters),
        let decodedimage = UIImage(data: dataDecoded) else { return nil }
        return decodedimage
    }
}
extension EmployeesTableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
}
