//
//  LoadingView.swift
//  WhetherTest
//
//  Created by MasamiYamate on 2019/04/12.
//  Copyright © 2019 MasamiYamate. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var loadingCircle: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func loadNib(){
        guard let view: LoadingView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? LoadingView else {
            return
        }
        view.frame = self.bounds
        view.loadingCircle = loadingCircle
        self.addSubview(view)
    }
    
    func close (complete: (() -> Void)?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.isHidden = true
            complete?()
        })
    }
    
    func open (complete: (() -> Void)?) {
        self.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        }, completion: {_ in
            complete?()
        })
    }
}
