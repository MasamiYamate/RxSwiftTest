//
//  Parameters.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation

class WTApi {
    //APIのエンドポイント群
    enum EndPoint: String {
        //livedoorのお天気APIの親エンドポイント
        case liveDoorWeather = "http://weather.livedoor.com/"
    }
    
    enum WhetherPath: String {
        case cityTagsPath = "forecast/rss/primary_area.xml"
        case whetherPath = "forecast/webservice/json/v1"
    }
    
}
