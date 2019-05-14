//
//  WhetherDetailViewController.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/10.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class WhetherDetailViewController: UIViewController {
    
    @IBOutlet weak var toDayDataView: UIView!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var toDayWhetherIcon: UIImageView!
    @IBOutlet weak var toDayTemperatureLabel: UILabel!
    
    @IBOutlet weak var dailyDataView: UIView!
    @IBOutlet weak var whetherScrollDataView: UIScrollView!
    
    @IBOutlet weak var commentaryTableView: UITableView!
    
    let presenter = WhetherDetailViewPresenter()
    
    var loadingView: LoadingView?
    
    var tableviewDataSource: RxTableViewSectionedReloadDataSource<CityTagModels>?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIの初期化
        setLoadingView()
        presenter.viewDidLoadTask()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: 初期化メソッド
    //購読の開始
    func setSubscription() {
        //LoadingViewの初期化
        let loadviewDisposable = presenter.loadView.subscribe(onNext: {value in
            self.loadingView?.isLoading(value)
        })
        disposeBag.insert(loadviewDisposable)
        //TableViewの初期化
        if tableviewDataSource != nil {
            presenter
        }
    }
    
    /// LoadingViewのセットアップ
    func setLoadingView () {
        let rect = UIScreen.main.bounds
        loadingView = LoadingView(frame: rect)
        if loadingView != nil {
            view.addSubview(loadingView!)
        }
    }

}
