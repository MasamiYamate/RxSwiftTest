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
        presenter.whetherData
            .subscribe(onNext: {value in
                self.areaNameLabel.text = value.title
                let toDayForecast = value.forecasts.filter { $0.dateType == WhetherForecastModel.DateType.toDay }
                if let toDayIconImgUrl: String = toDayForecast.first?.iconImgUrl {
                    self.toDayWhetherIcon.image = UIImage.webImage(url: toDayIconImgUrl)
                }
                if let maxtemp: String = toDayForecast.first?.maxTemp, let mintemp: String = toDayForecast.first?.minTemp {
                    self.toDayTemperatureLabel.text = "\(maxtemp)℃/\(mintemp)℃"
                }
            }).disposed(by: disposeBag)
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
                    let dailyView = DailyWhetherView(frame: setRect)
                    let forecast = value[index]
                    var setType: WhetherForecastModel.DateType = .toDay
                    switch index {
                    case 0:
                        setType = .toDay
                    case 1:
                        setType = .tomorrow
                    case 2:
                        setType = .dayAfterTomorrow
                    default:
                        continue
                    }
                    dailyView.dateLabel.text = setType.rawValue
                    dailyView.whetherIcon.image = UIImage.webImage(url: forecast.iconImgUrl)
                    let maxTemp: String = forecast.maxTemp
                    let minTemp: String = forecast.minTemp
                    dailyView.tempertureLabel.text = "\(maxTemp)℃/\(minTemp)℃"
                    self.whetherScrollDataView.addSubview(dailyView)
                    addXPos += setVW
                }
                let setContentsSize: CGSize = CGSize(width: addXPos, height: setVH)
                self.whetherScrollDataView.contentSize = setContentsSize
            }).disposed(by: disposeBag)
    }

}
