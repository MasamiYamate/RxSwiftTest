//
//  RepositoryProtocol.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//
//  各Repositoryの共通Protocol
//

import Foundation
import RxCocoa
import RxSwift

protocol RepositoryProtocol {
    associatedtype Output
    associatedtype DataStoreType
    var dataStore: DataStoreType { get }
    func request ()
}
