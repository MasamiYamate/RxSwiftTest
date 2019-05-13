//
//  DataStoreProtocol.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol DataStoreProtocol {
    associatedtype Output
    
    func request ()
}
