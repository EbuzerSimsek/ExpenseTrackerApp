//
//  ExpenseVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 18.07.2023.
//

import UIKit
import Parse
import DropDown

class ExpenseVC: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var ExpensesVCview: UIView!
    let myDropDown = DropDown()
    let ExpenseTypes = ["Book","Farmacy","Coffee","Plane","Food","Hotel","Transportation","Shopping"]
    

    
    @IBOutlet weak var ExpenseDescription: UITextField!
    @IBOutlet weak var ExpenseAmount: UITextField!
    @IBOutlet weak var ExpenseTypeLabel: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExpenseDescription.clipsToBounds = true
        ExpenseDescription.layer.cornerRadius = 10.0
        ExpenseDescription.layer.borderWidth = 0.5
        ExpenseDescription.layer.borderColor = UIColor.gray.cgColor
        ExpensesVCview.clipsToBounds = true
        ExpensesVCview.layer.cornerRadius = 30.0
        ExpenseTypeLabel.clipsToBounds = true
        ExpenseTypeLabel.layer.cornerRadius = 10.0
        ExpenseTypeLabel.layer.borderColor = UIColor.gray.cgColor
        ExpenseTypeLabel.layer.borderWidth = 0.5
        button.clipsToBounds = true
        button.layer.cornerRadius = 30.0
        
        
        myDropDown.anchorView = ExpenseTypeLabel
        myDropDown.dataSource = ExpenseTypes
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        myDropDown.selectionAction = { (index : Int, item : String) in
            self.ExpenseTypeLabel.text = self.ExpenseTypes[index]
            self.ExpenseTypeLabel.textColor = .black
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white
            ]
            
            
            self.ExpenseAmount.attributedPlaceholder = NSAttributedString(string: "0", attributes: attributes)
            self.ExpenseAmount.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
            self.title = "Expenses"
            
        }
    }
    
   
    
    func GetCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        let dateString = formatter.string(from: Date(timeIntervalSince1970: currentTime))
        return dateString
    }
    
  
    
    @IBAction func DropDownMenuTapped(_ sender: Any) {
        myDropDown.show()
    }
    

    @IBAction func ContinueButton(_ sender: Any) {
        let ExpenseAmount = Int(ExpenseAmount.text!)
        let object = PFObject(className: "Income")
        object["ExpenseDescription"] = ExpenseDescription.text
        object["Expenses"] = ExpenseAmount
        object["postOwner"] = PFUser.current()!.username
        object["ExpenseType"] = ExpenseTypeLabel.text
        object["ExpenseTime"] = GetCurrentTime()
        
        object.saveInBackground { success, error in
            if error != nil {
                error?.localizedDescription
            } else {
               
                self.performSegue(withIdentifier: "ExpenseToMainVC", sender: nil)
            }
        }
    }

}
