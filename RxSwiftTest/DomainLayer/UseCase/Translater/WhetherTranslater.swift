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

class WhetherTranslater: TranslaterProtocol {
    typealias Input = JSON
    typealias Output = WhetherDataModel
    
    var subject: PublishSubject<WhetherDataModel> {
        return PublishSubject<WhetherDataModel>()
    }
    
    func translate(_ value: JSON) {
        subject.onNext(WhetherDataModel(json: value))
    }
    
}
