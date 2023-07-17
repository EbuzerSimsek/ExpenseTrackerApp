//
//  Logo2.swift
//  Pods
//
//  Created by Ebuzer Şimşek on 14.07.2023.
//

import UIKit

class Logo2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextPage), userInfo: nil, repeats: false)
    }
    
    @objc func showNextPage() {
        performSegue(withIdentifier: "logoToTabBar", sender: nil)
    }
}
