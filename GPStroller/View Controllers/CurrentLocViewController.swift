//
//  CurrentLocViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/27/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentLocViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()

        // Do any additional setup after loading the view.
    }
    
    func setUpLocationManager(){
        locationManager.delegate = (self as CLLocationManagerDelegate)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4036.2832, longitudinalMeters: 7343.4658)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
        } else{
            //alert telling user to turn on
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case.authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //show alert instructing user how to turn on loc permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            //alert telling that access restricted
            break
        @unknown default:
            fatalError()
        }
    }

   
}
extension CurrentLocViewController: CLLocationManagerDelegate{
       
       func locationManager(_ manager: CLLocationManager, didupdateLocation locations: [CLLocation]){
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
           checkLocationAuthorization()
       }
   }
