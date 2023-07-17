//
//  WelcomeVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var SignUPButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    private let service = Service()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let red: CGFloat = 0.8
        let green: CGFloat = 0.2
        let blue: CGFloat = 0.4
        let alpha: CGFloat = 1.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        
    }
    

    @IBAction func SignUPButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
        
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
}
