//
//  BusinessMapViewController.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import UIKit
import MapKit

class BusinessMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
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
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "BusinessAnnotation")
    }
    //MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
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
        
        //make API call to find array of business
        //add annotations to map
        getBusinesses(around: location, with: 10.0) { (openBusinesses, error) in
            if let error = error {
                NSLog("Error getting businesses: \(error)")
                return
            }
            guard let openBusinesses = openBusinesses else {return}
            mapView.addAnnotations(openBusinesses)
        }
        
    }
    
    //makes API request using location and radius
    private func getBusinesses(around location: CLLocationCoordinate2D, with radius: Double, completion: ([Business]?, Error?)->Void){
        
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    //MARK: - Properties
    private var locationManager  = CLLocationManager()
    private var location: CLLocationCoordinate2D? {
        didSet{
            updateWithLocation()
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
}
