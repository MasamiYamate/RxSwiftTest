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

    typealias Output = CityTagRequest.Response
    
    var subject: PublishSubject<XML.Accessor> {
        return PublishSubject<XML.Accessor>()
    }
    
    func request() {
        let cityTagReq: CityTagRequest = CityTagRequest.init()
        Session.send(cityTagReq) { result in
            switch result {
            case .success(let res):
                self.subject.onNext(res)
            case .failure(let err):
                self.subject.onError(err)
            }
        }
    }
}
