//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by MasamiYamate on 2019/05/08.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let test = CityTagUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        test.observable.subscribe(onNext: {value in
            let abcds = value
            print("ここやで")
        }, onError: { error in
            print("えらーやで")
        }, onCompleted: {
            print("おわったで")
        }, onDisposed: {
            print("すてたで")
        })
        test.request()
    }

}
