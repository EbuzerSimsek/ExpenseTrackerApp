//
//  ProfileVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit
import Parse

class ProfileVC: UIViewController {

    private var model = User()
    private var service = Service()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        profileNameLabel.text = service.GetCurrentUser()["name"] as? String
        userName.text = service.GetCurrentUser().username
        
    }
  

    @IBAction func LogOutButtonClicked(_ sender: Any) {
        service.LogOutFunction(viewController: self)
    }
}
