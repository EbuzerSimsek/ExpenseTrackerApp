//
//  Service.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 14.07.2023.
//

import Foundation
import Parse
import UIKit


struct Service {
    
    private var model = User()
    
    
    func SignUpFunction(viewController: UIViewController,model : User) {
        
        let user = PFUser()
        user.username = model.username
        user.password = model.password
        user["name"] = model.name
        user.signUpInBackground { succes, error in
            if error != nil{
                self.makeAlert(viewController: viewController,titleInput: "Error", messageInput:error?.localizedDescription ?? "Username / Password??")
            } else {
                viewController.performSegue(withIdentifier: "toSalaryVC", sender: nil)
                
            }
        }
    }
    
    
    
    func SignInFunction(viewController:UIViewController,UserName:String,Password:String){
        
        PFUser.logInWithUsername(inBackground: UserName, password: Password) { user, error in
            if error != nil{
                self.makeAlert(viewController: viewController, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            }else {
                viewController.performSegue(withIdentifier: "LoginToMainVC", sender: nil)
            }
        }
        
    }
    
    
    func GetCurrentUser() -> PFUser {
        let current = PFUser.current()
        return current!
    }
    
    
    func GetSalary(Salary : inout Double,viewController:UIViewController){
        let object = PFObject(className: "Expenses")
        let uuid = UUID().uuidString
        let uuidExpensesAndIncomes = "\(uuid) \(PFUser.current()!.username!)"
        
        
//        object["accountOwner"] = PFUser.current()!.username!
//        object["income"] = PFUser.current()!["income"]
        object["uuidExpensesAndIncomes"] = uuidExpensesAndIncomes
        object["Salary"] = Salary
        
        
        object.saveInBackground { (success, error) in
            DispatchQueue.main.async {
                if let error = error {
                    makeAlert(viewController: viewController, titleInput: "Error", messageInput: error.localizedDescription)
                } else {
                    // Başarıyla kaydedildiğinde yapılacak işlemler
                }
            }
        }

        
    }
    
    
    
    
    
    
    func LogOutFunction(viewController:UIViewController){
        
        PFUser.logOutInBackground { error in
            if error != nil {
                makeAlert(viewController: viewController, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }
            else {
                viewController.performSegue(withIdentifier: "fromLogOutToWelcome", sender: nil)
            }
        }
        
    }
    
    
    
    
    
    func makeAlert(viewController: UIViewController,titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message:messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        viewController.present(alert,animated: true)
    }
    
}
