//
//  SettingViewController.swift
//  FirebaseInstaClone
//
//  Created by hasan bilgin on 4.10.2023.
//

import UIKit
//eklendi
import Firebase

class SettingViewControllers: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("error")
        }
    }
}
