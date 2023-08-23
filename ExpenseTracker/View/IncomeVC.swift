//
//  IncomeVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 18.07.2023.
//

import UIKit
import Parse
import DropDown

class IncomeVC: UIViewController {
    
    @IBOutlet weak var IncomeDescription: UITextField!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var DropDownMenuButtonImage: UIImageView!
    @IBOutlet weak var IncomeAmount: UITextField!
    
    @IBOutlet weak var IncomeView: UIView!
    
    @IBOutlet weak var incomTypeLabel: UILabel!
    
    let myDropDown = DropDown()
    let IncomeType = ["Salary","Debt"]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Button.clipsToBounds = true
        Button.layer.cornerRadius = 30.0
        
        IncomeView.clipsToBounds = true
        IncomeView.layer.cornerRadius = 30.0
        
        incomTypeLabel.layer.borderColor = UIColor.gray.cgColor
        incomTypeLabel.layer.borderWidth = 0.5
        incomTypeLabel.clipsToBounds = true
        incomTypeLabel.layer.cornerRadius = 10.0
        
        IncomeDescription.layer.borderColor = UIColor.gray.cgColor
        IncomeDescription.layer.borderWidth = 0.5
        IncomeDescription.clipsToBounds = true
        IncomeDescription.layer.cornerRadius = 10.0
        IncomeDescription.frame.size.height = 56.0
        
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        
        
        IncomeAmount.attributedPlaceholder = NSAttributedString(string: "0", attributes: attributes)
        IncomeAmount.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
        self.title = "Income"
        
        
        myDropDown.anchorView = incomTypeLabel
        myDropDown.dataSource = IncomeType
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        myDropDown.selectionAction = { (index : Int, item : String) in
            self.incomTypeLabel.text = self.IncomeType[index]
            self.incomTypeLabel.textColor = .black
            
        }
        
    }
    
    
    
    
    @IBAction func dropDownButton(_ sender: Any) {
        myDropDown.show()
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // İmleci yanıp sönme animasyonuyla göster
            IncomeAmount.tintColor = .clear
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.IncomeAmount.tintColor = .white
            }, completion: nil)
        }
    
    
 
    
    func GetCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        let dateString = formatter.string(from: Date(timeIntervalSince1970: currentTime))
        return dateString
    }
    
    
    
    
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        
        var IntIncomeAmount = Int(IncomeAmount.text!)
        
        let object = PFObject(className: "Income")
        object["ExpenseDescription"] = IncomeDescription.text
        object["IncomeValue"] = IntIncomeAmount
        object["postOwner"] = PFUser.current()!.username
        object["ExpenseType"] = incomTypeLabel.text
        object["ExpenseTime"] = GetCurrentTime()
        
        object.saveInBackground { succes, error in
            if error != nil {
                error?.localizedDescription
            } else {
                self.performSegue(withIdentifier: "IncomeToMain", sender: nil)
            }
        }
        
        
    }
    
}
