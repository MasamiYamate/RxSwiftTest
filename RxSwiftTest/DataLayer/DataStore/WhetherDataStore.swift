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

struct WhetherDataStore {

    typealias Output = JSON
    
    func request(cityId: String) -> Observable<Output> {
        return Observable<Output>.create { observable in
            let whetherReq: WhetherRequest = WhetherRequest.init(cityId: cityId)
            Session.send(whetherReq) { result in
                switch result {
                case .success(let res):
                    observable.onNext(res)
                    observable.onCompleted()
                case .failure(let err):
                    observable.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
}
