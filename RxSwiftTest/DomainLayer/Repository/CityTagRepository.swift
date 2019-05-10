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
    
    var subject: PublishSubject<XML.Accessor> {
        return PublishSubject<XML.Accessor>()
    }
    
    var dataStore: CityTagDataStore {
        return CityTagDataStore()
    }
    
    private var disponsable: Disposable?
    
    init () {
        //init時にイベントの購読を開始させる
        self.setSubscription()
    }

    //購読開始のイベント
    func setSubscription() {
        disponsable = dataStore.subject.subscribe(onNext: {value in
            self.subject.onNext(value)
        }, onError: { error in
            self.subject.onError(error)
        }, onCompleted: {
            self.subject.onCompleted()
        }, onDisposed: {
            self.subject.dispose()
        })
    }
    
}
