//
//  ViewController1.swift
//  FirebaseHelloWorld
//
//  Created by Mathias Møller Feldt on 04/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func downloadImage(_ sender: Any) {
         //Calls static method and prints message if succes
        CloudStorage.downloadImage(name:"dog.jpg", imageView:imageView)
    
    }
}
