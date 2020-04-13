//
//  Note.swift
//  FirebaseHelloWorld
//
//  Created by Mathias Møller Feldt on 28/02/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import Foundation

class Note {
    var id:     String
    var head:   String
    var body:   String
    var imageName: String
    
    init(id:String, head:String, body:String, imageName:String) {
        self.id = id
        self.head = head
        self.body = body
        self.imageName = imageName
    }
    
    func toString() -> String {
        return ("id: " + id + "imageNmae: " + imageName)
    }
    
}
