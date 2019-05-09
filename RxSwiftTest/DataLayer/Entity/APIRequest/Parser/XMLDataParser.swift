//
//  XMLDataParser.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//
//  APIKit標準では、Data to Jsonのみ対応しているため
//  Data to XMLに対応するためのクラス
//


import Foundation
import APIKit
import SwiftyXMLParser

final class XMLDataParser: DataParser {
    
    var contentType: String? {
        return "application/xml"
    }
    
    func parse(data: Data) throws -> Any {
        return XML.parse(data)
    }
    
}
