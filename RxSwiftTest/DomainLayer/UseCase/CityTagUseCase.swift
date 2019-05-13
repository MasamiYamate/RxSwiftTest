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

class CityTagUseCase {
    
    // MARK: Presenterからアクセスするデータ群
    private var tags: CityModels?
    
    // MARK: データリクエストに必要なリポジトリ
    private let cityTagRepo: CityTagRepository = CityTagRepository()
    
    private var disponsable: Disposable?
    
    // MARK: 初期化
    init() {
        self.setSubscription()
    }
    
    //購読開始のイベント
    private func setSubscription() {
      
    }

}
