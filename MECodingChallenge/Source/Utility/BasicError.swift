//
//  BasicError.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
/// TransactionError is an Enumeration that contains information about any TransactionErrors.  The Enumeration inherets from the Error protocol.
///
/// - invalidRequest: Provices an idication that the Transaction performed is not valid due to a invalid transaction.
enum BasicError: Error {
    case invalidResponse
}
