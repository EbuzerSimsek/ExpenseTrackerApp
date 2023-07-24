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
    
    let myDropDown = DropDown()
    let ExpenseTypes = ["Book","Farmacy","Coffee","Plane","Food","Hotel","Transportation","Shopping"]
    

    
    @IBOutlet weak var ExpenseAmount: UITextField!
    
    @IBOutlet weak var ExpenseTypeLabel: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDropDown.anchorView = ExpenseTypeLabel
        myDropDown.dataSource = ExpenseTypes
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        myDropDown.selectionAction = { (index : Int, item : String) in
            self.ExpenseTypeLabel.text = self.ExpenseTypes[index]
            self.ExpenseTypeLabel.textColor = .white
            
            
        }
    }
    
   
    
    func GetCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        let dateString = formatter.string(from: Date(timeIntervalSince1970: currentTime))
        return dateString
    }
    
    @IBAction func DropDownMenuButton(_ sender: Any) {
        myDropDown.show()
    }
    


    @IBAction func ContinueButton(_ sender: Any) {
        var ExpenseAmount = Int(ExpenseAmount.text!)
        let object = PFObject(className: "Income")
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
