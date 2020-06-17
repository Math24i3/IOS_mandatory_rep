//
//  CloudStorage.swift
//  UploadImage
//
//  Created by Mathias Møller Feldt on 17/06/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class CloudStorage {
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage()
    
    
    static func uploadImage(imageView: UIImageView, imageName: String){
        let imageToUpload = imageView.image
        guard let data = imageToUpload?.pngData() else { return print("Not valid") }
        let storageRef = storage.reference().child(imageName)
        
        storageRef.putData(data, metadata: nil) { (metadata, error) in
        if let error = error {
          print(error)
          return
        } else {
            print("succes")
            }
        }
    }
    
    static func downloadImage(name:String, imageView:UIImageView){
        let imgRef = storage.reference(withPath: name)
        //Get file handler
        imgRef.getData(maxSize: 4000000) { (data, error) in
            if error == nil {
                print("Success downloading the image: ", name)
                let img = UIImage(data: data!) //Setting the data (image)
                DispatchQueue.main.async { //Prevent background thread from
                    //interupting the main thread
                    imageView.image = img
                }
            } else {
                print("Error :(")
            }
        }
    }
}
