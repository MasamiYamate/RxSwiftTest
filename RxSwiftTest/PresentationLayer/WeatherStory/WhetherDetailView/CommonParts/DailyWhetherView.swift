//
//  DailyWhetherView.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/11.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

class DailyWhetherView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var whetherIcon: UIImageView!
    @IBOutlet weak var tempertureLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func loadNib(){
        guard let view: DailyWhetherView = Bundle.main.loadNibNamed("DailyWhetherView", owner: self, options: nil)?.first as? DailyWhetherView else {
            return
        }
        view.frame = self.bounds
        dateLabel = view.dateLabel
        whetherIcon = view.whetherIcon
        whetherIcon.contentMode = .scaleAspectFit
        tempertureLabel = view.tempertureLabel
        self.addSubview(view)
    }

}
