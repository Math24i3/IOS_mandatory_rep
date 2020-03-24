//
//  FirebaseRepo.swift
//  MapDemonstration
//
//  Created by Mathias Møller Feldt on 20/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import Foundation
import FirebaseFirestore
class FirebaseRepo {

    private static let db = Firestore.firestore() // gets the Firebase instance
    private static let path = "locations"
    
    static func startListener(vc: ViewController){
        print("listener started")
        // when there is a result, call
        //vc.updateMarkers()
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {  // check if there is an error. If so, then return
                return
            }
            if let newSnap = snap { //we check if the snap has a value
               vc.updateMarkers(snap: newSnap)
            }
            
            
        }
    }
    
    static func addMarker(title:String, lat:Double, long:Double){
        let ref = db.collection(path).document()
        var map = [String:Any]()
        map["text"] = title
        map["coordinates"] = GeoPoint(latitude: lat, longitude: long)
        ref.setData(map)
    }
    
}
