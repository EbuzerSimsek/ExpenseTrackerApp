//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 14.07.2023.
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
    
    private var model = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 255/255, green: 246/255, blue: 228/255, alpha: 1.0).cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        ExpensesView.layer.cornerRadius = 20.0
        ExpensesView.layer.masksToBounds = true
        IncomeView.layer.cornerRadius = 20.0
        IncomeView.layer.masksToBounds = true
        
//        if let incomeValue = model.ExpenseAndIncome?.income {
//            var stringValue = String(incomeValue)
//            stringValue = income.text!
//        }


        
    }
    
    
    @IBAction func ExpensesButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyBoard.instantiateViewController(identifier: "popUpVC")
        mainTabBarController.modalPresentationStyle = .popover
//        mainTabBarController.modalTransitionStyle = .crossDissolve
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
    
}
