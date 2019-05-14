//
//  WhetherUseCase.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/13.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift

class WhetherUseCase {
    
    // MARK: データリクエストに必要なリポジトリ
    private var whetherRepo: WhetherRepository
    private var whetherTrans: WhetherTranslater
    
    private var subject: PublishSubject<WhetherDataModel> = PublishSubject<WhetherDataModel>()
    var observable: Observable<WhetherDataModel> {
        return subject
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: 初期化
    init(cityId useId: String) {
        whetherRepo = WhetherRepository(cityId: useId)
        whetherTrans = WhetherTranslater()
        setSubscription()
    }
    
    //購読開始のイベント
    private func setSubscription() {
        let disponsable = whetherRepo.observable.subscribe(onNext: {value in
            do {
                let res = try self.whetherTrans.translate(value)
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
        disposeBag.insert(disponsable)
    }

    func request () {
        whetherRepo.request()
    }
    
}
