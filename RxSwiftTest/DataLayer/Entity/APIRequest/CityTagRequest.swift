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
import RxCocoa
import RxSwift

struct CityTagRequest: APIRequest {
    typealias Response = XML.Accessor
    
    var reqURL: String = WTApi.EndPoint.liveDoorWeather.rawValue
    
    var path: String {
        return WTApi.WhetherPath.cityTagsPath.rawValue
    }
    
    var dataParser: DataParser {
        return XMLDataParser()
    }
    
    var prms: [String: Any] = [:]
    
    var reqMethod: HTTPMethod = .get
    
    init() {}
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> XML.Accessor {
        guard let result: XML.Accessor = object as? XML.Accessor else {
            throw ResponseError.unexpectedObject(object)
        }
        return result
    }
    
}
