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
    

    private func getZoneFromCoordinate(coordinate: CLLocationCoordinate2D, completion:(String?, Error?)->Void){
        
        //        let request = URLRequest(url: <#T##URL#>)
        //        URLSession.shared.dataTask(with: <#T##URLRequest#>) { (results, _, error) in
        //
        //        }
        
    }
    
    private func getURLForNWS(location: CLLocationCoordinate2D, severity: [Severity]) -> URL?{
        let baseURL = URL(string: "https://api.weather.gov/alerts")!
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!

        //create URLQueryItems to build request
        let active = URLQueryItem(name: "active", value: "true")
        
        //make severity into a string for value as query item
        var severityString:String = severity.reduce(""){
            $0 + "\($1.rawValue),"
        }
        //remove extra comma from end of string
        _ = severityString.popLast()
        let severity = URLQueryItem(name: "severity", value: severityString)
        
        //add point
        let coordinate = "\(location.latitude),\(location.longitude)"
        let point = URLQueryItem(name: "point", value: coordinate)
        
        urlComponents.queryItems = [active,severity,point]
        
        return urlComponents.url
    }
    

    
    
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
