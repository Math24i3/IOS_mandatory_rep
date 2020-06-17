//
//  LoginViewController.swift
//  UploadImage
//
//  Created by Mathias Møller Feldt on 17/06/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet var unTxtField: UITextField!
    
    @IBOutlet var pwTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        Auth.auth().signIn(withEmail: unTxtField.text!, password: pwTxtField.text!) { [weak self] authResult, error in
            if error != nil {
                print("The user does not exist")
            } else {
                print("user exists!")
                self?.performSegue(withIdentifier: "seque1", sender: LoginViewController())
            }
        }
    }
    
    @IBAction func createDemoBtn(_ sender: Any) {
        Auth.auth().createUser(withEmail: "feldt.mathias@hotmail.com", password: "111111") { (authResult, error) in
            if error != nil {
                print(error)
            } else {
                print("user created")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
