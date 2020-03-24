//
//  ViewController.swift
//  MapDemonstration
//
//  Created by Mathias Møller Feldt on 20/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class ViewController: UIViewController, MKMapViewDelegate {
    
    
    var marker = MKPointAnnotation()
    
    var cgPoint = CGPoint()
    var coordinate2D = CLLocationCoordinate2D()
    
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    
   
    @IBOutlet weak var createMarkerLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var txtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        FirebaseRepo.startListener(vc: self)
        map.showsUserLocation = true
        
        createMarkerLabel.isHidden = true
        saveBtn.isHidden = true
        txtField.isHidden = true
    }
    
    
    
    
    var selectedAnnotation: MKPointAnnotation?
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
        
        print(self.selectedAnnotation?.coordinate.latitude as Any)
    }
    
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended{
            cgPoint = sender.location(in: map)
            coordinate2D = map.convert(cgPoint, toCoordinateFrom: map)
            print("long \(coordinate2D.latitude)")
            
            createMarkerLabel.isHidden = false
            txtField.isHidden = false
            saveBtn.isHidden = false
        }
        
    }
    
    
    
    @IBAction func saveMarker(_ sender: Any) {
        FirebaseRepo.addMarker(title: txtField.text!, lat: coordinate2D.latitude, long: coordinate2D.longitude)
        
        txtField.text = ""
        txtField.isHidden = true
        createMarkerLabel.isHidden = true
        saveBtn.isHidden = true
    }
    
    @IBAction func updLocBtn(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func stopUpdLocBtn(_ sender: Any) {
        locationManager.stopUpdatingLocation()
    }
    
    func updateMarkers(snap: QuerySnapshot) {
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap) //call adapter to convert data
        print("updating markers...")
        // make a loop, iterating through the markers list
        map.removeAnnotations(map.annotations) // clear the map
        map.addAnnotations(markers)
        
    }
    
    fileprivate func createDemoMarker(){
        let marker = MKPointAnnotation()
        marker.title = "Go here"
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5)
        marker.coordinate = location
        map.addAnnotation(marker)
    }

}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new location \(String(describing: locations.first?.coordinate))")
        if let coord = locations.last?.coordinate {
            
        
        let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
        map.setRegion(region, animated: true)
        }
    }
}

