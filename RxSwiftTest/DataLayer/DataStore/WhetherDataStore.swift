//
//  WhetherDataStore.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import APIKit
import SwiftyJSON
import RxCocoa
import RxSwift

struct WhetherDataStore: DataStoreProtocol {
    
    typealias Output = JSON
    
    var subject: PublishSubject<JSON> {
        return PublishSubject<JSON>()
    }

    var searchId: String = ""
    
    init(cityId: String) {
        searchId = cityId
    }
    
    func request() {
        let whetherReq: WhetherRequest = WhetherRequest.init(cityId: searchId)
        Session.send(whetherReq) { result in
            switch result {
            case .success(let res):
                self.subject.onNext(res)
            case .failure(let err):
                self.subject.onError(err)
            }
        }
    }
    
}
