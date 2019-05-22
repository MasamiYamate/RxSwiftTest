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
    
    // MARK: データリクエストに必要なリポジトリ
    private let cityTagRepo: CityTagRepository = CityTagRepository()
    private let cityTagTrans: CityTagTranslater = CityTagTranslater()

    private let disposeBag = DisposeBag()
    
    func request () -> Observable<[CityTagModels]> {
        return Observable<[CityTagModels]>.create({ observable in
            let cityTagRepoObservable = self.cityTagRepo.request()
            cityTagRepoObservable.subscribe(onNext: { value in
                do {
                    let res: [CityTagModels] = try self.cityTagTrans.translate(value)
                    observable.onNext(res)
                    observable.onCompleted()
                } catch {
                    observable.onError(error)
                }
            }, onError: {error in
                observable.onError(error)
            }, onCompleted: {
                observable.onCompleted()
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }

}
