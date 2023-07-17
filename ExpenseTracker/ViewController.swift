//
//  MainVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var IncomeView: UIView!
    
    @IBOutlet weak var ExpensesView: UIView!
    
    @IBOutlet weak var income: UILabel!
    
    @IBOutlet weak var expenses: UILabel!
    
    
    @IBOutlet weak var incomeAndExpensesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExpensesView.layer.cornerRadius = 10.0
        ExpensesView.layer.masksToBounds = true
        IncomeView.layer.cornerRadius = 10.0
        IncomeView.layer.masksToBounds = true
        
        
        
    }
    
    


}
