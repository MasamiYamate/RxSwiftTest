//
//  CityTagRequest.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import APIKit
import SwiftyXMLParser

struct CityTagRequest: APIRequest {
    typealias Response = XML.Accessor?
    
    var reqURL: String = WTApi.EndPoint.LIVEDOOR_WEATHER.rawValue
    
    var path: String {
        return WTApi.WhetherPath.CITY_TAGS_PATH.rawValue
    }
    
    var dataParser: DataParser {
        return XMLDataParser()
    }
    
    var prms: [String : Any] = [:]
    
    var reqMethod: HTTPMethod = .get
    
    init() {}
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> CityTagRequest.Response {
        guard let result: XML.Accessor = object as? XML.Accessor else {
            print("\(self) get error")
            return nil
        }
        return result
    }
    
}
