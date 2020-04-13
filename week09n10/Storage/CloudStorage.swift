//
//  CloudStorage.swift
//  FirebaseHelloWorld
//
//  Created by Mathias Møller Feldt on 28/02/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class CloudStorage{
    static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage()
    private static let notes = "notes"
    
    //download and set an image
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
    //Listen
    static func listener(tableview:UITableView){
        db.collection(notes).addSnapshotListener() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                list.removeAll()
                for note in querySnapshot!.documents {
                    
                    // print("\(note.documentID) => \(note.data())")
                    let map = note.data()
                    
                    let headStr = map["head"] as! String
                    let bodyStr = map["body"] as! String
                    let imageStr = map["img"] as! String
                    let newNote = Note(id: note.documentID, head: headStr, body: bodyStr, imageName: imageStr)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableview.reloadData()
                }
            }
        }
    }
    
    //Get size of list
    static func getSize() -> Int{
        return list.count
    }
    
    static func getNoteAt(index:Int) -> Note {
        return list[index]
    }
    
    //Add
    static func addNote(head:String, body:String, image:String){
        let ref = db.collection(notes).document()
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["img"] = image
        ref.setData(map)
    }
    //Delete
    static func deleteNote(index:Int, id:String){
        let docRef = db.collection(notes).document(id)
        list.remove(at: index)
        docRef.delete()
    }
    //Update
    static func updateNote(index:Int, head:String, body:String){
        let note = list[index]
        //let newNote = Note(id: note.id, head: head, body: body)
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["img"] = list[index].imageName
        list[index].head = head
        list[index].body = body
        docRef.setData(map)
    }
}
