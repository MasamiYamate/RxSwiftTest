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
    
    enum AreaSelectViewPresenterError: Error {
        case indexOutOfRange(String)
    }
    
    private let loadViewRelay = BehaviorRelay(value: true)
    var loadView: Observable<Bool> {
        return loadViewRelay.asObservable()
    }
    
    private let cityTagsDataRelay = BehaviorRelay<[CityTagModels]>(value: [])
    var cityTags: Observable<[CityTagModels]> {
        return cityTagsDataRelay.asObservable()
    }
    
    private let selectDataRelay = PublishRelay<CityTagModel>()
    var selectData: Observable<CityTagModel> {
        return selectDataRelay.asObservable()
    }
    
    private let errorRelay = PublishRelay<Error>()
    var error: Observable<Error> {
        return errorRelay.asObservable()
    }

    private var cityTagUseCase: CityTagUseCase
    
    var citesData: [CityTagModels] = []
    
    private let disposeBag = DisposeBag()
    
    // MARK: 初期化メソッド群
    init() {
        cityTagUseCase = CityTagUseCase()
    }
    
    func startLoading () {
        loadViewRelay.accept(true)
    }
    
    func stopLoading () {
        loadViewRelay.accept(false)
    }
    
    func requestCityTagsData () {
        startLoading()
        cityTagUseCase.request().subscribe(onNext: { value in
            self.stopLoading()
            self.citesData = value
            self.cityTagsDataRelay.accept(value)
        }, onError: {error in
            self.stopLoading()
            self.errorRelay.accept(error)
        }).disposed(by: disposeBag)
    }
    
    func selectCity (index: IndexPath) {
        if index.section < citesData.count {
            let cityData: CityTagModels = citesData[index.section]
            if index.row < cityData.items.count {
                let cityTagData = cityData.items[index.row]
                selectDataRelay.accept(cityTagData)
            } else {
                let errMsg = "AreaSelectViewPresenter cityData row path error"
                let err = AreaSelectViewPresenterError.indexOutOfRange(errMsg)
                errorRelay.accept(err)
            }
        } else {
            let errMsg = "AreaSelectViewPresenter citesData section path error"
            let err = AreaSelectViewPresenterError.indexOutOfRange(errMsg)
            errorRelay.accept(err)
        }
    }

}
