//
//  AreaSuggestViewPresenter.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AreaSelectViewPresenter: PresenterProtocol {
    
    private let loadViewSubject = BehaviorSubject(value: true)
    var loadView: Observable<Bool> {
        return loadViewSubject
    }
    
    private let cityTagsDataSubject = BehaviorSubject<[CityTagModels]>(value: [])
    var cityTags: Observable<[CityTagModels]> {
        return cityTagsDataSubject
    }

    private var cityTagUseCase: CityTagUseCase
    
    private let disposeBag = DisposeBag()
    
    // MARK: 初期化メソッド群
    init() {
        cityTagUseCase = CityTagUseCase()
        setSubscription()
    }
    
    /// 購読のイベント登録
    func setSubscription() {
        cityTagUseCase.observable.subscribe(onNext: {value in
            self.stopLoading()
            self.cityTagsDataSubject.onNext(value)
        }, onError: {error in
            self.cityTagsDataSubject.onError(error)
        }, onCompleted: {
            self.cityTagsDataSubject.onCompleted()
        }, onDisposed: {
            self.cityTagsDataSubject.dispose()
        }).disposed(by: disposeBag)
    }

    func startLoading () {
        loadViewSubject.onNext(true)
    }
    
    func stopLoading () {
        loadViewSubject.onNext(false)
    }
    
    func requestCityTagsData () {
        startLoading()
        cityTagUseCase.request()
    }

}
