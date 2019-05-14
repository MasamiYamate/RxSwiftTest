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

class WhetherRepository: RepositoryProtocol {
    typealias Output = JSON
    typealias DataStoreType = WhetherDataStore
    
    private var subject: PublishSubject<Output> = PublishSubject<Output>()

    var observable: Observable<Output> {
        return subject
    }
    
    var dataStore: DataStoreType

    private let disposeBag = DisposeBag()
    
    init (cityId: String) {
        //DataStoreの初期化
        dataStore = WhetherDataStore(cityId: cityId)
        //init時にイベントの購読を開始させる
        setSubscription()
    }
    
    //購読開始のイベント
    func setSubscription() {
        let disponsable = dataStore.observable.subscribe(onNext: { value in
            self.subject.onNext(value)
        }, onError: { error in
            self.subject.onError(error)
        }, onCompleted: {
            self.subject.onCompleted()
        }, onDisposed: {
            self.subject.dispose()
        })
        disposeBag.insert(disponsable)
    }
    
    func request () {
        dataStore.request()
    }
    
}
