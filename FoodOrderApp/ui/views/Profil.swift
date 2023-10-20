//
//  Profil.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import UIKit
import Firebase

class Profil: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        } catch {
            print("error")
        }
    }
}
