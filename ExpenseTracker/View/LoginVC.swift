//
//  LoginVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit

class LoginVC: UIViewController {

    private var service = Service()
    
    @IBOutlet weak var LoginUserName: UITextField!
    
    @IBOutlet weak var LoginPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
        service.SignInFunction(viewController: self, UserName: LoginUserName.text!, Password: LoginPassword.text!)
        
    }
    
}
