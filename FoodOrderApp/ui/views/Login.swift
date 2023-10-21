//
//  Login.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit
import Firebase

class Login: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var acikanLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        acikanLabel.font = UIFont(name: "Lobster-Regular", size: 45)
       
        
    }

    
    @IBAction func loginButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    //go to home screen
                    self.performSegue(withIdentifier: "toNext", sender: self)
                }
            }
        }else {
            makeAlert(titleInput: "Error!", messageInput: "Kullanıcı adı/Şifre?")
        }
    }
    
    
    @IBAction func uyeOlButton(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func login(email:String, password:String){
        
    }
    
}
