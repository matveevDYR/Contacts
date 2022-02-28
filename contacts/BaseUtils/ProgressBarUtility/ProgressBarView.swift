//
//  ProgressBarView.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    func show(_ controller: UIViewController){
        messageLabel.text = "Please wait"
        
        frame = UIScreen.main.bounds
        indicatorActivity.startAnimating()
        if let navigationController = controller.navigationController {
            navigationController.view.addSubview(self)
        } else {
            controller.view.addSubview(self)
        }
        self.layoutIfNeeded()
    }
    func dismiss(){
        self.removeFromSuperview()
    }
}
