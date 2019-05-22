//
//  WhetherRequest.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import APIKit
import SwiftyJSON

struct WhetherRequest: APIRequest {
    typealias Response = JSON
    
    var reqURL: String = WTApi.EndPoint.liveDoorWeather.rawValue
    
    var path: String {
        return WTApi.WhetherPath.whetherPath.rawValue
    }
    
    var prms: [String: Any] = [:]
    
    var reqMethod: HTTPMethod = .get
    
    init(cityId: String) {
        prms["city"] = cityId
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> JSON {
        return JSON(object)
    }
    
}
