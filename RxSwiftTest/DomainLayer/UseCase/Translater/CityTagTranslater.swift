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

class CityTagTranslater: TranslaterProtocol {
    typealias Input = XML.Accessor
    typealias Output = CityTagModels
    
    enum CityTagTranslaterError: Error {
        case notFound(String)
    }
    
    var subject: PublishSubject<CityTagModels> {
        return PublishSubject<CityTagModels>()
    }
    
    func translate(_ value: XML.Accessor) {
        guard let rss: XML.Element = value.element?.childElements[0] else {
            let err = CityTagTranslaterError.notFound("CityTagTranslater Not found rss")
            subject.onError(err)
            return
        }
        //index out of range対策で、念のためindexの個数確認を行う
        if rss.childElements.count == 0 {
            let err = CityTagTranslaterError.notFound("CityTagTranslater Not found channel")
            subject.onError(err)
            return
        }
        let channel: XML.Element = rss.childElements[0]
        var tmpAllArea: XML.Element?
        for channelChild in channel.childElements where channelChild.name == "ldWeather:source" {
            tmpAllArea = channelChild
            break
        }
        
        guard let allArea: XML.Element = tmpAllArea else {
            let err = CityTagTranslaterError.notFound("CityTagTranslater Not found allArea")
            subject.onError(err)
            return
        }
        
        do {
            let models = try CityTagModels.init(xml: allArea)
            subject.onNext(models)
        } catch {
            subject.onError(error)
        }
    }

}
