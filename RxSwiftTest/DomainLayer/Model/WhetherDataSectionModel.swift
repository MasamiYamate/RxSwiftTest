//
//  WhetherDataSectionModel.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/14.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

struct ContentsData {
    var contents: String
}

struct WhetherDataSectionModel {
    var headerName: String
    var items: [ContentsData]
}

extension WhetherDataSectionModel: SectionModelType {
    typealias Item = ContentsData
    
    init(original: WhetherDataSectionModel, items: [ContentsData]) {
        self = original
        self.items = items
    }
}
