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
    
    @IBOutlet weak var IncomeAmount: UITextField!
    
    
    @IBOutlet weak var incomTypeLabel: UILabel!
    
    let myDropDown = DropDown()
    let IncomeType = ["Salary","Debt"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white // Placeholder rengi burada kırmızı olarak belirlendi
        ]
        
        IncomeAmount.attributedPlaceholder = NSAttributedString(string: "Type Amount Here", attributes: attributes)
        IncomeAmount.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
        self.title = "Income"
        
        
        myDropDown.anchorView = incomTypeLabel
        myDropDown.dataSource = IncomeType
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        myDropDown.selectionAction = { (index : Int, item : String) in
            self.incomTypeLabel.text = self.IncomeType[index]
            self.incomTypeLabel.textColor = .white
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // İmleci yanıp sönme animasyonuyla göster
            IncomeAmount.tintColor = .clear
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.IncomeAmount.tintColor = .white
            }, completion: nil)
        }
    
    
    
    @IBAction func dropDownMenuButton(_ sender: Any) {
        myDropDown.show()
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
