//
//  CityTagTranslater.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/13.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import RxCocoa
import RxSwift
import RxDataSources

class CityTagTranslater: TranslaterProtocol {
    
    typealias Input = XML.Accessor
    typealias Output = Observable<[SectionModel<String, CityTagModel>]>
    
    enum CityTagTranslaterError: Error {
        case notFound(String)
    }
    
    func translate(_ value: XML.Accessor) throws -> Observable<[SectionModel<String, CityTagModel>]> {
        guard let rss: XML.Element = value.element?.childElements[0] else {
            throw CityTagTranslaterError.notFound("CityTagTranslater Not found rss")
        }
        //index out of range対策で、念のためindexの個数確認を行う
        if rss.childElements.count == 0 {
            throw CityTagTranslaterError.notFound("CityTagTranslater Not found channel")
        }
        let channel: XML.Element = rss.childElements[0]
        var tmpAllArea: XML.Element?
        for channelChild in channel.childElements where channelChild.name == "ldWeather:source" {
            tmpAllArea = channelChild
            break
        }
        
        guard let allArea: XML.Element = tmpAllArea else {
            throw CityTagTranslaterError.notFound("CityTagTranslater Not found allArea")
        }
        
        var tmpCitydata: CityModels?
        do {
            tmpCitydata = try CityModels.init(xml: allArea)
        } catch {
            throw error
        }
        
        guard let cityData: CityModels = tmpCitydata else {
            throw CityTagTranslaterError.notFound("CityTagTranslater Not found models")
        }
        return getAreaSectionModels(areas: cityData.areas, models: cityData.models)
    }
    
    private func getAreaSectionModels (areas: [String], models setModels: [String: [CityTagModel]]) -> Observable<[SectionModel<String, CityTagModel>]> {
        var res: [SectionModel<String, CityTagModel>] = []
        for area in areas {
            let models: [CityTagModel] = setModels[area] ?? []
            res.append(SectionModel(model: area, items: models))
        }
        return Observable.just(res)
    }

}
