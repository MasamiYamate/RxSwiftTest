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

    private let disposeBag = DisposeBag()
    
    // MARK: 初期化
    init() {
        whetherRepo = WhetherRepository()
        whetherTrans = WhetherTranslater()
    }
    
    func request (cityId: String) -> Observable<WhetherDataModel> {
        return Observable<WhetherDataModel>.create({observable in
            let repoObservable = self.whetherRepo.request(cityId: cityId)
            repoObservable.subscribe(onNext: { value in
                do {
                    let res = try self.whetherTrans.translate(value)
                    observable.onNext(res)
                    observable.onCompleted()
                } catch {
                    observable.onError(error)
                }
            }, onError: { error in
                observable.onError(error)
            }, onDisposed: {
                observable.onCompleted()
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
    
}
