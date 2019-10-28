//
//  String+Localized.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
//String+Localized exension is an extension that is used to Localize Strings within the app.
extension String {
    public static let empty: String = ""
    var localized: String {
        return NSLocalizedString(self, comment: .empty)
    }
}

