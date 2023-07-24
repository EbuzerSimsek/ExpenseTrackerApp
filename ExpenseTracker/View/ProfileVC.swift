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
     
        self.title = "Profile"
        if let currentUser = PFUser.current() {
            if let username = currentUser.username {
                userName.text = "\("@")\(username)"
                profileNameLabel.text = currentUser["name"] as? String
                
                if let imageFile = PFUser.current()?["image"] as? PFFileObject {
                    imageFile.getDataInBackground { (data, error) in
                        if let imageData = data, let image = UIImage(data: imageData) {
                            self.profileImage.image = image
                        } else {
                            self.service.makeAlert(viewController: self, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                        }
                    }
                } else {
                    // Kullanıcının resim alanı boş veya geçersiz
                }
                
            }
        }
        
    }
  

    @IBAction func LogOutButtonClicked(_ sender: Any) {
        service.LogOutFunction(viewController: self)
    }
}
