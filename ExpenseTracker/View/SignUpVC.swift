//
//  SignUpVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit

class SignUpVC: UIViewController {

    private var service = Service()
    
    private var model = User()
    
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }
 
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        model.name = NameTextField.text!
        model.password = PasswordTextField.text!
        model.username = UserName.text!
        
        service.SignUpFunction(viewController: self,model : model)
        
        
    }
    
}
