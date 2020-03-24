//
//  MapDataAdapter.swift
//  MapDemonstration
//
//  Created by Mathias Møller Feldt on 20/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class MapDataAdapter {
    
    static func getMKAnnotationsFromData(snap:QuerySnapshot) -> [MKPointAnnotation] {
        var markers = [MKPointAnnotation]() // create an empty list
        for doc in snap.documents {
            print("received data: ")
            let map = doc.data() // the data is delivered in a map
            let text = map["text"] as! String
            print(text)
            let geoPoint = map["coordinates"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
            print(geoPoint)
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = text
            let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
        }
        return markers
    }
    
    
}
