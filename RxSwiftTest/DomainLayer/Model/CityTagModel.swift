//
//  CityTagModel.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import SwiftyXMLParser

//全国の地域名、エリア名を保持するオブジェクト
class CityTagModels: NSObject {
    //Dictionaryでは順番が担保されないため
    //Area表記は別の配列として保持する
    private(set) var areas: [String] = []
    //Area名をKeyにAreaに紐づくCityTagModelの配列保持させる
    private(set) var models: [String: [CityTagModel]] = [:]
    
    init (xml: XML.Element) throws {
        for child in xml.childElements where child.name == "pref" {
            //pref配下に各地域名などが含まれる
            guard let areaName: String = child.attributes["title"] else {
                //エリア名称が取得できない場合はNSErrorを
                throw NSError(domain: "CityTagModels Not found area name", code: -1, userInfo: nil)
            }
            areas.append(areaName)
            var tmpModels: [CityTagModel] = []
            //pref配下のchildElementsから各地域情報を取得する
            for prefChild in child.childElements where prefChild.name == "city" {
                //警報情報も含まれるので、cityの場合の時だけ処理を行う
                let tmpCityModel: CityTagModel = CityTagModel.init(xml: prefChild)
                if !tmpCityModel.name.isEmpty && !tmpCityModel.cityId.isEmpty {
                    tmpModels.append(tmpCityModel)
                }
            }
            //地域名をKeyに各CityModelをディクショナリーにセット
            //道南のみ複数存在しているため、既にkeyが存在する場合は
            //既存の配列の末尾に追加する
            if let existData: [CityTagModel] = models[areaName] {
                models[areaName] = existData + tmpModels
            } else {
                models[areaName] = tmpModels
            }
        }
        //全てのデータ処理後、名称の配列から重複値を取り除く
        let orderdSet: NSOrderedSet = NSOrderedSet(array: areas)
        guard let orderdSetArea: [String] = orderdSet.array as? [String] else {
            throw NSError(domain: "CityTagModels orderdSetArea cast error", code: -2, userInfo: nil)
        }
        areas = orderdSetArea
    }
}

class CityTagModel: NSObject {
    private(set) var name: String
    private(set) var cityId: String
    
    init(xml: XML.Element) {
        name = xml.attributes["title"] ?? ""
        cityId = xml.attributes["id"] ?? ""
    }
}
