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

struct WhetherDataStore: DataStoreProtocol  {
    
    typealias Output = JSON
    
    var dataStoreSubject: PublishSubject<JSON> {
        return PublishSubject<JSON>()
    }

    var searchId: String = ""
    
    init(_ id: String) {
        searchId = id
    }
    
    func request() {
        let whetherReq: WhetherRequest = WhetherRequest.init(searchId)
        Session.send(whetherReq) { result in
            switch result {
            case .success(let res):
                self.dataStoreSubject.onNext(res)
            case .failure(let err):
                self.dataStoreSubject.onError(err)
            }
        }
    }
    
}
