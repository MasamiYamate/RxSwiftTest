//
//  LoadingViewController.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingCircle: UIActivityIndicatorView!
    
    var presenter = LoadingViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //PresenterにViewControllerを渡す
        presenter.viewDidLoadTask(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppearTask()
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
    
    /// AreaSuggestViewに遷移します
    func jumpAreaSuggestView () {
        stopLoading()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LoadingViewToWhetherStory", sender: nil)
        }
    }

}
