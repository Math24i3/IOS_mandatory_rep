//
//  ViewController.swift
//  UploadImage
//
//  Created by Mathias Møller Feldt on 17/06/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageTxtField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imageTxtField.delegate = self
    }
    @IBAction func uploadImagebtn(_ sender: Any) {
        CloudStorage.uploadImage(imageView: imageView, imageName: imageTxtField.text!)
        imageTxtField.text = ""
    }
    
    @IBAction func downloadImageBtn(_ sender: Any) {
        
        CloudStorage.downloadImage(name: imageTxtField.text!, imageView: imageView)
        imageTxtField.text = ""
    }
    
    @IBAction func photoRollBtn(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func takePhoto(_ sender: Any) {
        launchCamera()
    }
    
    fileprivate func launchCamera(){
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       if let url = info[.mediaURL] as? URL {
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
            }
            
            } else {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imageView.image = image
            }
        picker.dismiss(animated: true, completion: nil)
        
    }
}

