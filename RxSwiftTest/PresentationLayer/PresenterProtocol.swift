//
//  PresenterProtocol.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

protocol PresenterProtocol {
    associatedtype VC
    
    var viewController: VC? {get set}
    
}

extension PresenterProtocol {
    
    mutating func viewDidLoadTask (_ vc: VC) {
        self.viewController = vc
    }
    
    func viewWillAppearTask () {}
    
    func viewWillLayoutSubviewsTask () {}
    
    func viewDidLayoutSubviewsTask () {}
    
    func viewDidAppearTask () {}
    
    func viewWillDisappearTask () {}
    
    func viewDidDisappearTask () {}
    
    func prepareTask(for segue: UIStoryboardSegue, sender: Any?) {}
    
}
