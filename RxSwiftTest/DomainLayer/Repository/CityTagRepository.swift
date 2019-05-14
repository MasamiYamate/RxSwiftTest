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
    
    private var subject: PublishSubject<XML.Accessor> = PublishSubject<XML.Accessor>()
    var observable: Observable<Output> {
        return subject
    }

    var dataStore: CityTagDataStore

    private let disposeBag = DisposeBag()
    
    init () {
        dataStore = CityTagDataStore()
        //init時にイベントの購読を開始させる
        self.setSubscription()
    }

    //購読開始のイベント
    func setSubscription() {
        let disponsable = dataStore.observable.subscribe(onNext: {value in
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
    
    /// データリクエストのメソッド
    func request () {
        dataStore.request()
    }
}
