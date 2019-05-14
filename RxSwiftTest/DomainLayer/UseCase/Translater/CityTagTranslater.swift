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
    typealias Output = [CityTagModels]
    
    enum CityTagTranslaterError: Error {
        case notFound(String)
    }
    
    func translate(_ value: XML.Accessor) throws -> [CityTagModels] {
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
        return getAreaModels(xml: allArea)
    }
    
    private func getAreaModels (xml: XML.Element) -> [CityTagModels] {
        var areaNames: [String] = []
        var res: [CityTagModels] = []
        for child in xml.childElements where child.name == "pref" {
            if let tmpModel: CityTagModels = try? CityTagModels(xml: child) {
                //道南のみ重複値があるため既に道南処理済みの場合は既存のCityModelsのmodelsに追加する
                if areaNames.firstIndex(of: tmpModel.areaName) != nil {
                    for (idx, model) in res.enumerated() where model.areaName == tmpModel.areaName {
                        let items = model.items + tmpModel.items
                        res[idx] = CityTagModels.init(areaName: model.areaName, models: items)
                    }
                }else{
                    areaNames.append(tmpModel.areaName)
                    res.append(tmpModel)
                }
            }
        }
        return res
    }

}
