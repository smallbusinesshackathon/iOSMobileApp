//
//  BusinessMapViewController.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import UIKit
import MapKit

class BusinessMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
//        guard let avgCoordinate =  storeController.averageStoreCoordinate() else {return}
//        let viewRegion = MKCoordinateRegion(center: avgCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
//        mapView.setRegion(viewRegion, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MapAnnotation")
    }

    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            NSLog("Empty location array")
            return
        }
        self.location = location.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Error getting location: \(error)")
    }
    
    //MARK: MapViewDelegate Method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let businessAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: "BusinessAnnotation", for: annotation) as! MKMarkerAnnotationView
        businessAnnotation.markerTintColor = .darkGray
        businessAnnotation.glyphTintColor = .white
        
        businessAnnotation.canShowCallout = true
        
        //TODO: Implement detailView
        return businessAnnotation
    }
    
    //MARK: - Private
    private func updateWithLocation(){
        //Zoom to user location
        guard let location = location else {return}
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(viewRegion, animated: true)
        
        //TODO: - make API calls for Requests/Offers and handle the response
        
        //Find local alerts
        
    }
    
    //MARK: - Private Networking Functions
    

    
    
    //MARK: - Properties
    private var locationManager  = CLLocationManager()
    private var location: CLLocationCoordinate2D? {
        didSet{
            updateWithLocation()
        }
    }
    
    private var offers = [Offer]()
    private var requests = [Request]()
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
}
