//
//  ViewControllerAdd.swift
//  FirebaseHelloWorld
//
//  Created by Mathias Møller Feldt on 05/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewControllerAdd: UIViewController {

    @IBOutlet weak var imagetxtField: UITextField!
    @IBOutlet weak var headField: UITextField!
    @IBOutlet weak var bodyView: UITextView!
    @IBOutlet weak var navItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNote(_ sender: Any) {
        if imagetxtField.text == ""{
            imagetxtField.text = "dog.jpg"
        }
        CloudStorage.addNote(head: headField.text!, body: bodyView.text!, image: imagetxtField.text!)
        headField.text = ""
        bodyView.text = ""
        imagetxtField.text = ""
        
        
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
