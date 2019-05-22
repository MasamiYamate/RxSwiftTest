//
//  CityTagDataStore.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//
//  livedoor天気情報の一次細分区定義表のDataStore
//

import Foundation
import APIKit
import SwiftyXMLParser
import RxCocoa
import RxSwift

/// livedoor天気情報の一次細分区定義表のDataStore
struct CityTagDataStore: DataStoreProtocol {
    typealias Output = XML.Accessor
    
    func request() -> Observable<XML.Accessor> {
        return Observable<Output>.create { observable in
            let cityTagReq: CityTagRequest = CityTagRequest.init()
            Session.send(cityTagReq) { result in
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
