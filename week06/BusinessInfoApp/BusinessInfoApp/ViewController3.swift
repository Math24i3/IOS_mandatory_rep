//
//  ViewController3.swift
//  BusinessInfoApp
//
//  Created by Mathias Møller Feldt on 07/02/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    

    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var messageTxtField: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var name = ""
    var message = ""
    
    var view4 = ViewController4()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    // Do any additional setup after loading the view.
    }    
    @IBAction func onSubmit(_ sender: Any) {
        self.name = nameTxtField.text!
        self.message = messageTxtField.text!
        performSegue(withIdentifier: "submitContact", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController4
        vc.finalName = self.name
        vc.finalMessage = self.message
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
