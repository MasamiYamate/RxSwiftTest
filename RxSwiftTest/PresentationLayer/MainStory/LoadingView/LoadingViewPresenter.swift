//
//  LoadingViewPresenter.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoadingViewPresenter: PresenterProtocol {
    
    private let loadCircleAnimateSubject = BehaviorRelay(value: true)
    var loadCircleAnimate: Observable<Bool> {
        return loadCircleAnimateSubject.asObservable()
    }

    private let viewTransitionSubject = PublishSubject<Void>()
    var viewTransition: Observable<Void> {
        return viewTransitionSubject
    }
    
    // MARK: 初期化メソッド群
    init() {}
    
    // MARK: UIイベントなど
    /// Loadingの開始
    func startLoading () {
      //  loadCircleAnimateSubject.bindNext(true)
    }
    
    /// Loadingの終了
    func stopLoading () {
      //  loadCircleAnimateSubject.bindNext(false)
    }
    
    /// Viewの遷移
    func nextViewTransition () {
        viewTransitionSubject.onNext()
    }
    
}
