//
//  Signup.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit
import Firebase

class Signup: UIViewController {

    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func girisYapButton(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    

    @IBAction func signUpButton(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {(authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toLogin", sender: self)
                }
            }
            
        }else {
            makeAlert(titleInput: "Error!", messageInput: "Kullanıcı adı/Şifre?")
        }
        
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func signUp (email:String, password:String, fullName:String, confirm:String){
        
    }
    

}
