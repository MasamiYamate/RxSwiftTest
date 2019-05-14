//
//  LoadingViewController.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingCircle: UIActivityIndicatorView!
    
    let presenter = LoadingViewPresenter()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubscription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.nextViewTransition()
    }
    
    //購読の開始
    private func setSubscription() {
        //Loading circleの購読イベント
        let loadCircleDisposable = presenter.loadCircleAnimate.subscribe(onNext: {value in
            if value {
                self.startLoading()
            } else {
                self.stopLoading()
            }
        })
        disposeBag.insert(loadCircleDisposable)
        //Viewの遷移イベント
        let viewTransition = presenter.viewTransition.subscribe(onNext: {
            self.nextViewTransition()
        })
        disposeBag.insert(viewTransition)
    }
    
    // MARK: UIイベントなど
    /// Loadingの開始
    func startLoading () {
        DispatchQueue.main.async {
            self.loadingCircle.startAnimating()
        }
    }

    /// Loadingの終了
    func stopLoading () {
        DispatchQueue.main.async {
            self.loadingCircle.stopAnimating()
        }
    }
    
    /// Viewの遷移
    func nextViewTransition () {
        presenter.stopLoading()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LoadingViewToWhetherStory", sender: nil)
        }
    }

}
