//
//  TranslaterProtocol.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/13.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TranslaterProtocol {
    associatedtype Input
    associatedtype Output
    func translate(_ value: Input) throws -> Output
}
