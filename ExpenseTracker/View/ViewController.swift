//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 14.07.2023.
//


import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var IncomeView: UIView!
    @IBOutlet weak var ExpensesView: UIView!
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var expenses: UILabel!
    @IBOutlet weak var incomeAndExpensesTableView: UITableView!
    @IBOutlet weak var IncomeVC: UIImageView!
    @IBOutlet weak var ExpenseVC: UIImageView!
    
    
    
    func DataUpdate(){
        getData()
    }
    
    private var model = User()
    private var service = Service()
    
    var postOwnerArray = [String]()
    var IncomeValueArray = [Int]()
    var ExpenseValueArray = [Int]()
    var ExpensesImageArray = [UIImage]()
    var ExpensesTypeArray = [String]()
    var ExpensesTimeArray = [String]()
    var ExpensesDetailArray = [String]()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getProfileImage(ImageView: profileImage, viewController: self)
        
        incomeAndExpensesTableView.dataSource = self
        incomeAndExpensesTableView.delegate = self
        
        
        DispatchQueue.main.async {
            self.getData()
        }
        
        
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
        
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(ExpenseVCButton))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(IncomeVCButton))
        ExpenseVC.addGestureRecognizer(gestureRecognizer1)
        IncomeVC.addGestureRecognizer(gestureRecognizer2)
        
        let initialIncome = 0
        let initialExpense = 0
        
        // Değişkenlere başlangıç değerlerini atayın
        income.text = String(initialIncome)
        expenses.text = String(initialExpense)
        
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }

    

    
    func getData() {
        
        let query = PFQuery(className: "Income")
        query.addDescendingOrder("createdAt")
        query.whereKey("postOwner", equalTo: PFUser.current()!.username)
      
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                error?.localizedDescription
            } else {
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.IncomeValueArray.removeAll(keepingCapacity: false)
                self.ExpenseValueArray.removeAll(keepingCapacity: false)
                self.ExpensesTypeArray.removeAll(keepingCapacity: false)
                self.ExpensesTimeArray.removeAll(keepingCapacity: false)
                self.ExpensesDetailArray.removeAll(keepingCapacity: false)
                
                
                
                if objects!.count > 0 {
                    for object in objects! {
                        self.postOwnerArray.append(object.object(forKey: "postOwner") as! String)
                        
                        // Gelir değerini opsiyonel olarak ekleyin ve nil değeri 0 olarak düşünün
                        let incomeValue = object.object(forKey: "IncomeValue") as? Int ?? 0
                        self.IncomeValueArray.append(incomeValue)
                        
                        // Gider değerini opsiyonel olarak ekleyin ve nil değeri 0 olarak düşünün
                        let expenseValue = object.object(forKey: "Expenses") as? Int ?? 0
                        self.ExpenseValueArray.append(expenseValue)
                        
                        let ExpenseType = object.object(forKey:"ExpenseType") as? String
                        
                        self.ExpensesTypeArray.append(ExpenseType ?? "Expense")
                    
                        
                        let StringDate = object.object(forKey: "ExpenseTime") as? String
                        self.ExpensesTimeArray.append(StringDate ?? "Time")
                        
                        
                        let ExpensesDescription = object.object(forKey: "ExpenseDescription") as? String
                        
                        self.ExpensesDetailArray.append(ExpensesDescription ?? "ExpenseDescription")
                       
                        
                    }
                    
                    // Gelir ve gider değerlerini toplayın
                    let Income = self.IncomeValueArray.compactMap { $0 }.reduce(0, +)
                    let Expense = self.ExpenseValueArray.compactMap { $0 }.reduce(0, +)
                    
                    // Diğer işlemler ...
                    let Balance = "$\(Income - Expense)"
                    self.income.text = "$\(Income)"
                    self.expenses.text = "$\(Expense)"
                    self.accountBalance.text = String(Balance)
                    
                    self.incomeAndExpensesTableView.reloadData()
                    print(self.ExpenseValueArray)
                }
            }
        }
    }
    
    
    
    
    @objc func ExpenseVCButton() {
        performSegue(withIdentifier: "ToExpenseVC", sender: nil)
    }
    
    @objc func IncomeVCButton() {
        performSegue(withIdentifier: "ToIncomeVC", sender: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExpenseValueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesCustomCell", for: indexPath) as! ExpenseAndIncomeCell
        
        let StringExpenseValue = String(ExpenseValueArray[indexPath.row])
        
        let StringIncomeValue = String(IncomeValueArray[indexPath.row])
        
        cell.ExpenseTime.text = ExpensesTimeArray[indexPath.row]    
        
        let expenseCategory = ExpensesTypeArray[indexPath.row]
        
        cell.ExpenseDetail.text = ExpensesDetailArray[indexPath.row]
 
        
        
        
        
        
        
        switch expenseCategory {
        case "Salary":
            cell.ExpenseType.text = "Salary"
            cell.ExpenseAmount.textColor = UIColor(red: 0/255, green: 168/255, blue: 107/255, alpha: 1.0)
            cell.ExpenseAmount.text = "+\(StringIncomeValue)$"
            cell.ExpenseTypeImage.image = UIImage(named: "salary")
        case "Debt":
            cell.ExpenseType.text = "Debt"
            cell.ExpenseAmount.textColor = UIColor(red: 0/255, green: 168/255, blue: 107/255, alpha: 1.0)
            cell.ExpenseAmount.text = "+\(StringIncomeValue)$"
            cell.ExpenseTypeImage.image = UIImage(named: "debt")
        case "Shopping":
            cell.ExpenseTypeImage.image = UIImage(named: "shopping")
            cell.ExpenseType.text = "Shopping"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case "Transportation":
            cell.ExpenseTypeImage.image = UIImage(named: "transportation")
            cell.ExpenseType.text = "Transportation"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case  "Farmacy":
            cell.ExpenseTypeImage.image = UIImage(named: "farmacy")
            cell.ExpenseType.text = "Farmacy"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case  "Plane":
            cell.ExpenseTypeImage.image = UIImage(named: "plane")
            cell.ExpenseType.text = "Plane"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case  "Hotel":
            cell.ExpenseTypeImage.image = UIImage(named: "hotel")
            cell.ExpenseType.text = "Hotel"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case  "Coffee":
            cell.ExpenseTypeImage.image = UIImage(named: "coffee")
            cell.ExpenseType.text = "Coffee"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case "Book":
            cell.ExpenseTypeImage.image = UIImage(named: "book")
            cell.ExpenseType.text = "Book"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
        case "Food":
            cell.ExpenseTypeImage.image = UIImage(named: "food")
            cell.ExpenseType.text = "Food"
            cell.ExpenseAmount.text = "-\(StringExpenseValue)$"
            cell.ExpenseAmount.textColor = UIColor.red
            
        default:
            cell.ExpenseTypeImage.image = UIImage(named: "shopping")
            cell.ExpenseType.text = "shopping"
            cell.ExpenseAmount.text = StringExpenseValue
            cell.ExpenseAmount.textColor = UIColor.green
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

