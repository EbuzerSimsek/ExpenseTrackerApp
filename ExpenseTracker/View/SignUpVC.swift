//
//  SignUpVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 12.07.2023.
//

import UIKit

class SignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private var service = Service()
    
    private var model = User()
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        SignUpButton.isEnabled = false
        
        
    }
    
    
    @objc func choosePhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = false
        present(pickerController, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let squareImage = pickedImage.resizeToSquare()
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.image = squareImage
        }
        picker.dismiss(animated: true, completion: nil)
        SignUpButton.isEnabled = true
    }
    
    
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        model.name = NameTextField.text!
        model.password = PasswordTextField.text!
        model.username = UserName.text!
        
        
        service.SignUpFunction(viewController: self,model : model,image: profileImageView.image!)
        
        
    }
    
}
