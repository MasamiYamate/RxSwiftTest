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
    
    var reqURL: String = WTApi.EndPoint.LIVEDOOR_WEATHER.rawValue
    
    var path: String {
        return WTApi.WhetherPath.WHETHER_PATH.rawValue
    }
    
    var prms: [String : Any] = [:]
    
    var reqMethod: HTTPMethod = .get
    
    init(_ id: String) {
        prms["city"] = id
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> WhetherRequest.Response {
        return JSON(object)
    }
    
}
