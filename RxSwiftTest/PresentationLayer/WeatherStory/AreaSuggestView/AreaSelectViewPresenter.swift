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
//
////    // MARK: TableView生成に必要なデータを生成するメソッド群
////    /// セクションの総数(エリア名の総数)を取得します
////    ///
////    /// - Returns: AreaTotalCount
////    func getTotalSectionCount () -> Int {
////        return cityTagUseCase.getTotalSectionCount()
////    }
////
////    /// セクションに表示するエリア名を取得します
////    ///
////    /// - Parameter section: SectionNo
////    /// - Returns: AreaName
////    func getSectionTitle (_ section: Int) -> String {
////        return cityTagUseCase.getSectionTitle(section)
////    }
////
////    /// 各Areaに属する都市名の総数を取得します
////    ///
////    /// - Parameter section: SectionNo
////    /// - Returns: CityCount
////    func getTotalCityCount (_ section: Int) -> Int {
////        return cityTagUseCase.getTotalCityCount(section)
////    }
////
////    /// 指定位置のCityModelを取得します
////    ///
////    /// - Parameter indexPath: 表示対象CellのIndexPath
////    /// - Returns: 指定したCityModel
////    func getCityModel (_ indexPath: IndexPath) -> CityModel? {
////        return cityTagUseCase.getCityModel(indexPath)
////    }
//
//}
