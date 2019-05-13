//
//  LoadingViewPresenter.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation

class LoadingViewPresenter: PresenterProtocol {
    typealias VC = LoadingViewController
    
    var viewController: LoadingViewController?
    
    var cityTagUseCase: CityTagUseCase
    
    // MARK: 初期化メソッド群
    init() {
        cityTagUseCase = CityTagUseCase()
    }
    
    func viewDidAppearTask() {
        //View描画後、データ取得開始
        getCityData()
    }
    
    // MARK: データのリクエストなど
    /// Cityデータを取得する
    func getCityData () {
        cityTagUseCase.request({
            //データ取得後、画面遷移させる
            self.viewController?.jumpAreaSuggestView()
        })
    }
    
}
