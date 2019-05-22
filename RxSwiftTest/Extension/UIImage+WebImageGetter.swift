//
//  UIImage+WebImageGetter.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/22.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func webImage(url: String) -> UIImage? {
        guard let imgUrl: URL = URL(string: url) else {
            return nil
        }
        guard let imgData: Data = try? Data(contentsOf: imgUrl) else {
            return nil
        }
        return UIImage(data: imgData)
    }
    
}
