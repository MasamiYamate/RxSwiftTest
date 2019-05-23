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
    
    var tableviewDataSource: RxTableViewSectionedReloadDataSource<WhetherDataSectionModel>?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIの初期化
        setLoadingView()
        setToDayWhether()
        setScrollView()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.requestWhetherData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        loadingView?.removeFromSuperview()
        loadingView = nil
        for view in whetherScrollDataView.subviews {
            view.removeFromSuperview()
        }
    }
    
    // MARK: 初期化メソッド
    func setTableView() {
        tableviewDataSource = RxTableViewSectionedReloadDataSource<WhetherDataSectionModel>.init(configureCell: {(_, _, _, model) -> UITableViewCell in
            let cell = UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.text = model.contents
            return cell
        })
        //TableViewの初期化
        if tableviewDataSource != nil {
            presenter.whetherData
                .map({data in data.sectionDatas})
                .bind(to: commentaryTableView.rx.items(dataSource: tableviewDataSource!))
                .disposed(by: disposeBag)
        }
    }
    
    /// LoadingViewのセットアップ
    func setLoadingView () {
        let rect = UIScreen.main.bounds
        loadingView = LoadingView(frame: rect)
        if loadingView != nil {
            view.addSubview(loadingView!)
        }
        //LoadingViewの初期化
        presenter.loadView.subscribe(onNext: {value in
            self.loadingView?.isLoading(value)
        }).disposed(by: disposeBag)
    }
    
    func setToDayWhether () {
        //Area名称の設定を行う
        presenter.whetherData.map { value in
            return value.title
        }
        .bind(to: areaNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        let toDay = presenter.whetherData
            .flatMap { value -> Observable<WhetherForecastModel> in
                let toDayForecast = value.forecasts.filter { $0.dateType == WhetherForecastModel.DateType.toDay }.first
                return Observable.from(optional: toDayForecast)
        }
        
        //当日のお天気アイコンを設定します
        toDay.map { model in
            return UIImage.webImage(url: model.iconImgUrl)
        }
        .bind(to: toDayWhetherIcon.rx.image)
        .disposed(by: disposeBag)
        
        //今日の最低気温、最高気温を設定します
        toDay.map { model in
            return "\(model.maxTemp)℃/\(model.minTemp)℃"
        }
        .bind(to: toDayTemperatureLabel.rx.text)
        .disposed(by: disposeBag)

    }
    
    func setScrollView () {
        presenter.whetherData
            .map({data in data.forecasts})
            .subscribe(onNext: {value in
                var addXPos: CGFloat = 0.0
                let setVH: CGFloat = 80.0
                var setVW: CGFloat = 100.0
                //画面サイズの横幅よりもトータルが小さい場合、各Viewの横幅を調整する
                let windowW = UIScreen.main.bounds.width
                if (setVW * CGFloat(value.count)) < windowW {
                    setVW = windowW / CGFloat(value.count)
                }
                for index in 0..<value.count {
                    let setRect: CGRect = CGRect(x: addXPos, y: 0, width: setVW, height: setVH)
                    let dailyView = self.createForecastView(rect: setRect, idx: index)
                    self.whetherScrollDataView.addSubview(dailyView)
                    addXPos += setVW
                }
                let setContentsSize: CGSize = CGSize(width: addXPos, height: setVH)
                self.whetherScrollDataView.contentSize = setContentsSize
            }).disposed(by: disposeBag)
    }
    
    func createForecastView (rect: CGRect, idx: Int) -> UIView {
        let dailyView = DailyWhetherView(frame: rect)
        let forecat = presenter.whetherData.flatMap { value -> Observable<WhetherForecastModel> in
            return Observable.just(value.forecasts[idx])
        }
        var setType: WhetherForecastModel.DateType = .toDay
        switch idx {
        case 0:
            setType = .toDay
        case 1:
            setType = .tomorrow
        case 2:
            setType = .dayAfterTomorrow
        default:
            break
        }
        let dateType = Observable.just(setType.rawValue)
        dateType.bind(to: dailyView.dateLabel.rx.text)
        .disposed(by: disposeBag)
        forecat.map { model in
            return UIImage.webImage(url: model.iconImgUrl)
        }.bind(to: dailyView.whetherIcon.rx.image)
        .disposed(by: disposeBag)
        forecat.map { model in
            return "\(model.maxTemp)℃/\(model.minTemp)℃"
        }.bind(to: dailyView.tempertureLabel.rx.text)
        .disposed(by: disposeBag)
        return dailyView
    }

}
