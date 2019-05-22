//
//  CityTagModel.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/13.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import SwiftyXMLParser
import RxDataSources

struct CityTagModel {
    enum CityTagModelError: Error {
        case notFound(String)
    }
    
    private(set) var areaName: String
    private(set) var name: String
    private(set) var cityId: String
    
    init(xml: XML.Element, areaName setArea: String) throws {
        areaName = setArea
        guard let title: String = xml.attributes["title"] else {
            throw CityTagModelError.notFound("CityTagModel Not found title")
        }
        name = title
        guard let setCityid: String = xml.attributes["id"] else {
            throw CityTagModelError.notFound("CityTagModel Not found id")
        }
        cityId = setCityid
    }
}

extension CityTagModel: IdentifiableType {
    typealias Identity = String
    var identity: String { return cityId }
}
