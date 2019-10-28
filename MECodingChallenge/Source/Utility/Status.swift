//
//  Status.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
/// Status is an Enummeration that provides a common group of related values related to the Actions performed within the app.
///
/// - success: Provides the app with an indication that a function performed was successful.
/// - error: Provices the app with an indication that a function performed was not successful.
enum Status {
    case success
    case error
}
