//
//  ObserverType+onNext.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/14.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObserverType where Element == Void {
    public func onNext() {
        onNext(())
    }
}
