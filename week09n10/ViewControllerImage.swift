//
//  ViewControllerImage.swift
//  FirebaseHelloWorld
//
//  Created by Mathias Møller Feldt on 06/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewControllerImage: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headView: UITextView!
    @IBOutlet weak var bodyView: UITextView!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    var rowNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use row number to get the right note object
        let note = CloudStorage.getNoteAt(index: rowNumber)
        headView.text = note.head
        bodyView.text = note.body
        messageLabel.text = ""
        if note.imageName != ""{
            CloudStorage.downloadImage(name: note.imageName, imageView: imageView)
        } else{
            print("Fail, no pic attached to the note")
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func updateNote(_ sender: Any) {
        CloudStorage.updateNote(index: rowNumber, head: headView.text, body: bodyView.text)
        messageLabel.text = "Note has been updated!"
    }
    

}
