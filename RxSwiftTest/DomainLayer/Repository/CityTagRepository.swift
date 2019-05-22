//
//  CityTagRepository.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import RxCocoa
import RxSwift

class CityTagRepository: RepositoryProtocol {
    typealias Output = XML.Accessor
    typealias DataStoreType = CityTagDataStore

    var dataStore: CityTagDataStore

    private let disposeBag = DisposeBag()
    
    init () {
        dataStore = CityTagDataStore()
    }

    /// データリクエストのメソッド
    func request () -> Observable<Output> {
        return Observable<Output>.create { observable in
            let dataStoreObservable = self.dataStore.request()
            dataStoreObservable.subscribe(onNext: {value in
                observable.onNext(value)
                observable.onCompleted()
            }, onError: { error in
                observable.onError(error)
            }, onCompleted: {
                observable.onCompleted()
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
