//
//  WhetherForecastModel.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import SwiftyJSON

class WhetherForecastModel: NSObject {
    enum DateType: String {
        case toDay = "今日"
        case tomorrow = "明日"
        case dayAfterTomorrow = "明後日"
    }
    
    enum ForecastJsonKey: String {
        case date
        case dateLabel
        case telop
        case image
        case url
        case temperature
        case max
        case min
        case celsius
    }
    
    //予報日
    private(set) var date: Date?
    //予報日(今日 , 明日 , 明後日)
    private(set) var dateLabel: String = ""
    private(set) var dateType: DateType?
    
    //天気の種別 (晴れ、曇り、雨など)
    private(set) var telop: String = ""
    //アイコンのURL
    private(set) var iconImgUrl: String = ""
    
    //最高気温
    private(set) var maxTemp: String = "-"
    private(set) var minTemp: String = "-"
    
    init (data: JSON) {
        super.init()
        for (key, subJson): (String, JSON) in data {
            switch key {
            case ForecastJsonKey.date.rawValue:
                createDate(json: subJson)
            case ForecastJsonKey.dateLabel.rawValue:
                setDateLabel(json: subJson)
            case ForecastJsonKey.telop.rawValue:
                setTelop(json: subJson)
            case ForecastJsonKey.image.rawValue:
                setImage(json: subJson)
            case ForecastJsonKey.temperature.rawValue:
                setTmperature(json: subJson)
            default:
                break
            }
        }
    }
    
    private func createDate (json: JSON) {
        if let strDate: String = json.string {
            date = Date.parse(strDate, format: "yyyy-MM-dd")
        }
    }
    
    private func setDateLabel (json: JSON) {
        dateLabel = json.string ?? ""
        switch dateLabel {
        case DateType.toDay.rawValue:
            dateType = .toDay
        case DateType.tomorrow.rawValue:
            dateType = .tomorrow
        case DateType.dayAfterTomorrow.rawValue:
            dateType = .dayAfterTomorrow
        default:
            break
        }
    }
    
    private func setTelop (json: JSON) {
        telop = json.string ?? ""
    }
    
    private func setImage (json: JSON) {
        for (key, subJson): (String, JSON) in json where key == ForecastJsonKey.url.rawValue {
            iconImgUrl = subJson.string ?? ""
        }
    }
    
    private func setTmperature (json: JSON) {
        for (key, subJson): (String, JSON) in json {
            switch key {
            case ForecastJsonKey.max.rawValue:
                maxTemp = extractionCelsius(json: subJson) ?? "-"
            case ForecastJsonKey.min.rawValue:
                minTemp = extractionCelsius(json: subJson) ?? "-"
            default:
                break
            }
        }
    }
    
    private func extractionCelsius (json: JSON) -> String? {
        for (key, subJson): (String, JSON) in json where key == ForecastJsonKey.celsius.rawValue {
            return subJson.string
        }
        return nil
    }
    
}
