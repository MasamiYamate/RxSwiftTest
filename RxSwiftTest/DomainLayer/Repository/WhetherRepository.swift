//
//  WhetherRepository.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift

class WhetherRepository {
    typealias Output = JSON
    typealias DataStoreType = WhetherDataStore
    
    var dataStore: DataStoreType

    private let disposeBag = DisposeBag()
    
    init () {
        //DataStoreの初期化
        dataStore = WhetherDataStore()
    }

    func request (cityId: String) -> Observable<Output> {
        return Observable<Output>.create({observable in
            let dataStoreObservable = self.dataStore.request(cityId: cityId)
            dataStoreObservable.subscribe(onNext: {value in
                observable.onNext(value)
                observable.onCompleted()
            }, onError: {error in
                observable.onError(error)
            }, onCompleted: {
                observable.onCompleted()
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
    
}
