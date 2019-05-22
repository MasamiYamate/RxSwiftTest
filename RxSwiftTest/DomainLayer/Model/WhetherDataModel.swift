//
//  WhetherDataModel.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import SwiftyJSON

class WhetherDataModel: NSObject {
    
    enum WhetherDataJsonKey: String {
        case location
        case area
        case pref
        case city
        case title
        case link
        case publicTime
        case description
        case text
        case forecasts
        case copyright
        case image
        case url
        case provider
    }

    // MARK: Location
    // 地方名
    private(set) var area: String = ""
    // 都道府県名
    private(set) var pref: String = ""
    // 1次細分区名
    private(set) var city: String = ""
    
    // 見出し
    private(set) var title: String = ""
    // リクエストされたデータの地域に該当するlivedoor 天気情報のURL
    private(set) var link: String = ""
    // 予報の発表日時
    private(set) var publicTime: Date?
    
    // MARK: description
    // 天気概況文
    private(set) var guideText: String = ""
    // 概況分発表時刻
    private(set) var guidePublicTime: Date?
    
    // MARK: forecasts
    private(set) var forecasts: [WhetherForecastModel] = []
    
    // MARK: Copyright
    private(set) var cpTitle: String = ""
    private(set) var cpLink: String = ""
    private(set) var cpImgUrl: String = ""
    
    // MARK: provider
    private(set) var providers: [JSON] = []
    
    // MARK: SectionModels
    private(set) var sectionDatas: [WhetherDataSectionModel] = []
    
    init(json: JSON) {
        super.init()
        for (key, subJson): (String, JSON) in json {
            switch key {
            case WhetherDataJsonKey.location.rawValue:
                setLocation(json: subJson)
            case WhetherDataJsonKey.title.rawValue:
                setTitle(json: subJson)
            case WhetherDataJsonKey.link.rawValue:
                setLink(json: subJson)
            case WhetherDataJsonKey.publicTime.rawValue:
                setPublicTime(json: subJson)
            case WhetherDataJsonKey.description.rawValue:
                setDescription(json: subJson)
            case WhetherDataJsonKey.forecasts.rawValue:
                setForecasts(json: subJson)
            case WhetherDataJsonKey.copyright.rawValue:
                setCopyrightData(json: subJson)
            default:
                break
            }
        }
        createSectionData()
    }
    
    private func setLocation (json: JSON) {
        for (key, subJson): (String, JSON) in json {
            switch key {
            case WhetherDataJsonKey.area.rawValue:
                area = subJson.string ?? ""
            case WhetherDataJsonKey.pref.rawValue:
                pref = subJson.string ?? ""
            case WhetherDataJsonKey.city.rawValue:
                city = subJson.string ?? ""
            default:
                break
            }
        }
    }
    
    private func setTitle (json: JSON) {
        title = json.string ?? ""
    }
    
    private func setLink (json: JSON) {
        link = json.string ?? ""
    }
    
    private func setPublicTime (json: JSON) {
        if let strDate: String = json.string {
            publicTime = Date.parse(strDate, format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        }
    }
    
    private func setDescription (json: JSON) {
        for (key, subJson): (String, JSON) in json {
            switch key {
            case WhetherDataJsonKey.text.rawValue:
                guideText = subJson.string ?? ""
            case WhetherDataJsonKey.publicTime.rawValue:
                if let strDate: String = subJson.string {
                    guidePublicTime = Date.parse(strDate, format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
                }
            default:
                break
            }
        }
    }
    
    private func setForecasts (json: JSON) {
        for (_, subJson): (String, JSON) in json {
            let tmpForecastModel = WhetherForecastModel.init(data: subJson)
            forecasts.append(tmpForecastModel)
        }
    }
    
    private func setCopyrightData (json: JSON) {
        for (key, subJson): (String, JSON) in json {
            switch key {
            case WhetherDataJsonKey.title.rawValue:
                setCopyrightTitle(json: subJson)
            case WhetherDataJsonKey.link.rawValue:
                setCopyrightLink(json: subJson)
            case WhetherDataJsonKey.image.rawValue:
                setCopyrightImgUrl(json: subJson)
            case WhetherDataJsonKey.provider.rawValue:
                setProviders(json: subJson)
            default:
                break
            }
        }
    }
    
    private func setCopyrightTitle (json: JSON) {
        cpTitle = json.string ?? ""
    }
    
    private func setCopyrightLink (json: JSON) {
        cpLink = json.string ?? ""
    }
    
    private func setCopyrightImgUrl (json: JSON) {
        for (key, subJson): (String, JSON) in json where key == WhetherDataJsonKey.url.rawValue {
            cpImgUrl = subJson.string ?? ""
        }
    }
    
    private func setProviders (json: JSON) {
        for (_, subJson): (String, JSON) in json {
            providers.append(subJson)
        }
    }
    
    private func createSectionData () {
        sectionDatas.append(createWeatherForecastSection())
        sectionDatas.append(createProviderSections())
        sectionDatas.append(createCopyrightSections())
    }

    private func createWeatherForecastSection () -> WhetherDataSectionModel {
        let contents = ContentsData(contents: guideText)
        return WhetherDataSectionModel(headerName: "予報", items: [contents])
    }
    
    private func createProviderSections () -> WhetherDataSectionModel {
        var contentes: [ContentsData] = []
        for provider in providers {
            if let providerName: String = provider["name"].string {
                contentes.append(ContentsData(contents: providerName))
            }
        }
        return WhetherDataSectionModel(headerName: "気象データ 配信元", items: contentes)
    }
    
    private func createCopyrightSections () -> WhetherDataSectionModel {
        let contents = ContentsData(contents: cpTitle)
        return WhetherDataSectionModel(headerName: "Copyright", items: [contents])
    }
}
