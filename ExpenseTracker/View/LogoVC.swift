//
//  LogoVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit

class LogoVC: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
           
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextPage), userInfo: nil, repeats: false)
        }
        
        @objc func showNextPage() {
           performSegue(withIdentifier: "toNavigationController", sender: nil)
        }
    }
