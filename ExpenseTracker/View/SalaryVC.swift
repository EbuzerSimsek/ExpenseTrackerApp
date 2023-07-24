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
            
            let object = PFObject(className: "Income")
            object["IncomeValue"] = salaryValue
            object["postOwner"] = PFUser.current()?.username
            object["ExpenseType"] = "Salary"
            
            
            object.saveInBackground { succes, error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "toMessageVC", sender: nil)
                }
            }
            
            
            
        }

    }
}
