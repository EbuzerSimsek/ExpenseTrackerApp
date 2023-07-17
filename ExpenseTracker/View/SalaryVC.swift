//
//  SalaryVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 15.07.2023.
//

import UIKit
import Parse

class SalaryVC: UIViewController {
    
    @IBOutlet weak var salaryTextField: UITextField!
    private var service = Service()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    @IBAction func NextButton(_ sender: Any) {
        
        
        if let salaryText = salaryTextField.text, var salaryValue = Double(salaryText) {
           // service.GetSalary(Salary: &salaryValue, viewController: self)
            
            let object = PFObject(className: "Expenses")
            object["accountOwner"] = PFUser.current()!.username!
            object["salary"] = salaryValue
            
            
            object.saveInBackground { succes, error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("succes")
                }
            }
            
            
            
        }

    }
}
