//
//  WhetherDetailViewPresenter.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WhetherDetailViewPresenter: PresenterProtocol {
    
    private let loadViewRelay = BehaviorRelay<Bool>(value: true)
    var loadView: Observable<Bool> {
        return loadViewRelay.asObservable()
    }
    
    private let whetherDataRelay = PublishRelay<WhetherDataModel>()
    var whetherData: Observable<WhetherDataModel> {
        return whetherDataRelay.asObservable()
    }
    
    private let errorRelay = PublishRelay<Error>()
    var error: Observable<Error> {
        return errorRelay.asObservable()
    }
    
    var searchCityId: String?
    
    private var whetherUseCase: WhetherUseCase?
    
    private let disposeBag = DisposeBag()
    
    init() {
        whetherUseCase = WhetherUseCase()
    }

    func startLoading () {
        loadViewRelay.accept(true)
    }
    
    func stopLoading () {
        loadViewRelay.accept(false)
    }
    
    func requestWhetherData () {
        startLoading()
        guard let useId: String = searchCityId else {
            return
        }
        whetherUseCase?.request(cityId: useId).subscribe(onNext: { value in
            self.stopLoading()
            self.whetherDataRelay.accept(value)
        }, onError: {error in
            self.errorRelay.accept(error)
        }).disposed(by: disposeBag)
    }
    
}
