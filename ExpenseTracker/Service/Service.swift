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
    
    
    func SignUpFunction(viewController: UIViewController,model : User,image:UIImage) {
        
        let user = PFUser()
        user.username = model.username
        user.password = model.password
        user["name"] = model.name
        let data = image.jpegData(compressionQuality: 0.5)
        let pfimage = PFFileObject(name:"image.png", data: data!)
        user["image"] = pfimage

        
        
        
        
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
    
    func getProfileImage(ImageView:UIImageView,viewController:UIViewController){
        
        if let imageFile = PFUser.current()?["image"] as? PFFileObject {
            imageFile.getDataInBackground { (data, error) in
                if let imageData = data, var image = UIImage(data: imageData) {
                    
                    DispatchQueue.main.async {
                        ImageView.image = image
                    }
                    
                    
                } else {
                    makeAlert(viewController:viewController , titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
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
