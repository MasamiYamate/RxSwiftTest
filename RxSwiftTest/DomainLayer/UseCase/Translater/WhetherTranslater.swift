//
//  WhetherTranslater.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/13.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift
import RxDataSources

class WhetherTranslater: TranslaterProtocol {
    typealias Input = JSON
    typealias Output = WhetherDataModel
    
    func translate(_ value: JSON) throws -> WhetherDataModel {
        return WhetherDataModel(json: value)
    }
    
}
