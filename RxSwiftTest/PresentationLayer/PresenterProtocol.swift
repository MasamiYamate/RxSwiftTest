//
//  PresenterProtocol.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

protocol PresenterProtocol {}

extension PresenterProtocol {
    
    func viewDidLoadTask () {}
    
    func viewWillAppearTask () {}
    
    func viewWillLayoutSubviewsTask () {}
    
    func viewDidLayoutSubviewsTask () {}
    
    func viewDidAppearTask () {}
    
    func viewWillDisappearTask () {}
    
    func viewDidDisappearTask () {}

}
