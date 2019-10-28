//
//  EndpointConfig.swift
//  MECodingChallenge
//
//  Created by Marcel McFall on 28/10/19.
//  Copyright © 2019 Marcel McFall. All rights reserved.
//

import Foundation
// For debug build, if there was a prod environment it will be used.
// All the instances will have the same settings.
class EndpointConfig {
    static let sharedInstance = EndpointConfig()
    var endpoint: Endpoint
    private init() {
        let mainBundle = Bundle.main.infoDictionary
        var baseURL = ""
        if let url = mainBundle?["API_BASE_URL_ENDPOINT"] as? String {
          baseURL = url
        }
        endpoint = Endpoint(withBaseURL: baseURL)
    }
}
