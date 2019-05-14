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

class AreaSelectViewController: UIViewController {

    @IBOutlet weak var areaSelectTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//
//    // MARK: 初期化メソッド群
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter.viewDidLoadTask(self)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setupDelegate()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        areaSelectTableView.reloadData()
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let detailVc: WhetherDetailViewController = segue.destination as? WhetherDetailViewController {
//            guard let tmpCityId: String = sender as? String else {
//                return
//            }
//            detailVc.presenter.useCityId = tmpCityId
//        }
//    }
//
//    func setupDelegate () {
//        areaSelectTableView.delegate = self
//        areaSelectTableView.dataSource = self
//    }
//
//    // MARK: 画面遷移イベント
//    /// 天気詳細画面へ遷移
//    ///
//    /// - Parameter cityId: 詳細の天気を見たい都市のCityId
//    func jumpToWhetherDetailView (_ cityId: String) {
//        self.performSegue(withIdentifier: "AreaSelectViewToWhetherDetailView", sender: cityId)
//    }
//
//}
//
//extension AreaSelectViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return presenter.getTotalSectionCount()
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return presenter.getSectionTitle(section)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.getTotalCityCount(section)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.accessoryType = .disclosureIndicator
//        cell.textLabel?.text = ""
//        if let model: CityModel = presenter.getCityModel(indexPath) {
//            cell.textLabel?.text = model.name
//        }
//        return cell
//    }
//
//}
//
//extension AreaSelectViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let model: CityModel = presenter.getCityModel(indexPath) {
//            jumpToWhetherDetailView(model.id)
//        }
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}
