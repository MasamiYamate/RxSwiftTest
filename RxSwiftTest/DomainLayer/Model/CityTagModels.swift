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
struct CityTagModels {
    
    enum CityModelsError: Error {
        case notFound(String)
    }
    
    private(set) var areaName: String
    private(set) var items: [CityTagModel]
    
    init (xml: XML.Element) throws {
        //pref配下に各地域名などが含まれる
        guard let areaName: String = xml.attributes["title"] else {
            //エリア名称が取得できない場合はNSErrorを
            throw CityModelsError.notFound("CityTagModels Not found area name")
        }
    
        //pref配下のchildElementsから各地域情報を取得する
        for prefChild in xml.childElements where prefChild.name == "city" {
            //警報情報も含まれるので、cityの場合の時だけ処理を行う
            do {
                let tmpCityModel: CityTagModel = try CityTagModel.init(xml: prefChild, areaName: areaName)
                items.append(tmpCityModel)
            } catch {
                print(error)
            }
        }
    }
    
    init (areaName setAreaName: String , models setModels: [CityTagModel]) {
        areaName = setAreaName
        items = setModels
    }
    
}
