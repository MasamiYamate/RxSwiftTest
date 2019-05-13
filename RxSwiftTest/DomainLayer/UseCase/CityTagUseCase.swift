//
//  CityTagUseCase.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/13.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import RxCocoa
import RxSwift
import RxDataSources

class CityTagUseCase {
    
    // MARK: Presenterからアクセスするデータ群
    private var tags: CityModels?
    
    // MARK: データリクエストに必要なリポジトリ
    private let cityTagRepo: CityTagRepository = CityTagRepository()
    private let cityTagTans: CityTagTranslater = CityTagTranslater()
    
    private var subject: PublishSubject<[SectionModel<String, CityTagModel>]> = PublishSubject<[SectionModel<String, CityTagModel>]>()
    var observable: Observable<[SectionModel<String, CityTagModel>]> {
        return subject
    }
   
    private(set) var disponsable: Disposable?
    
    // MARK: 初期化
    init() {
        self.setSubscription()
    }
    
    //購読開始のイベント
    private func setSubscription() {
        disponsable = cityTagRepo.observable.subscribe(onNext: {value in
            do {
                let res = try self.cityTagTans.translate(value)
                self.subject.onNext(res)
            } catch {
                self.subject.onError(error)
            }
        }, onError: { error in
            self.subject.onError(error)
        }, onCompleted: {
            self.subject.onCompleted()
        }, onDisposed: {
            self.subject.dispose()
        })
    }
    
    func request () {
        cityTagRepo.request()
    }

}
