//
//  AreaSuggestViewController.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/09.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//
//  お天気情報のArea検索を行うView
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class AreaSelectViewController: UIViewController {

    @IBOutlet weak var areaSelectTableView: UITableView!
    
    let presenter = AreaSelectViewPresenter()
    
    var loadingView: LoadingView?
    
    var tableviewDataSource: RxTableViewSectionedReloadDataSource<CityTagModels>?
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        //UIの初期化
        setLoadingView()
        //delegateの設定
        areaSelectTableView.rx.setDelegate(self).disposed(by: disposeBag)
        //DataSourceの初期化
        setDataSource()
        setSubscription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.requestCityTagsData()
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
            presenter.cityTags.bind(to: areaSelectTableView.rx.items(dataSource: tableviewDataSource!)).disposed(by: disposeBag)
        }
    }
    
    /// TableViewのDataSourceを生成します
    func setDataSource() {
        tableviewDataSource = RxTableViewSectionedReloadDataSource<CityTagModels>(configureCell: {( _: TableViewSectionedDataSource<CityTagModels>, _: UITableView, _: IndexPath, model: CityTagModel) -> UITableViewCell in
            //セルの生成
            let cell = UITableViewCell()
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = model.name
            return cell
        }, titleForHeaderInSection: {dataSource, index in
            return dataSource.sectionModels[index].areaName
        })
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

extension AreaSelectViewController: UITableViewDelegate {

    //headerの高さ指定
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
}
