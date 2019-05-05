//
//  BusinessMapViewController.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import UIKit
import MapKit


let demoLocationDC = CLLocationCoordinate2D(latitude: 38.907192, longitude: -77.036873)

class BusinessMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        alertLabel.textColor = .white
        
        let color = severityRating["none"]!.color
        updateStatusBarColor(color: color)
        alertView.backgroundColor = color
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        tableView.reloadData()
        
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
    private func updateWithLocation(demo:Bool = false){
        //Zoom to user location
        
        let location = demo ? demoLocationDC : self.location! 
        //        guard let location = location else {return}
        //        let location = demoLocationDC
        
        let viewRegion = MKCoordinateRegion(center: demoLocationDC, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(viewRegion, animated: true)
        
        //TODO: - make API calls for Requests/Offers and handle the response
        
        //Find local alerts
        getAlertFromNWSAPI(coordinate: location) { (results, error) in
            if let error = error {
                NSLog("Error sending API request: \(error)")
                return
            }
            guard let results = results else {return}
            DispatchQueue.main.async {
                self.updateAlertLabel(alerts: results)
            }
        }
        
    }
    
    private func updateAlertLabel(alerts: [WeatherAlert]){
        if alerts.isEmpty{
            alertLabel.text = "There are no weather alerts in your current area"
        } else {
            guard let mostSevere = getMostSevereAlert(alerts: alerts) else {return}
            alertLabel.text = "\(mostSevere.severity): \(mostSevere.event)"
            let backgroundColor = severityRating[mostSevere.severity.lowercased()]!.color
            alertView.backgroundColor = backgroundColor
            updateStatusBarColor(color: backgroundColor)
        }
    }
    
    private func getMostSevereAlert(alerts: [WeatherAlert]) -> WeatherAlert? {
        let sorted = alerts.sorted{ severityRating[$0.severity.lowercased()]!.rating > severityRating [$1.severity.lowercased()]!.rating}
        
        return sorted.first
    }
    
    private func updateStatusBarColor(color: UIColor){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        
        statusBarView.backgroundColor = color
        view.addSubview(statusBarView)
    }
    
    //MARK: - Private Networking Functions
    
    
    private func getAlertFromNWSAPI(coordinate: CLLocationCoordinate2D, completion:@escaping ([WeatherAlert]?, Error?)->Void){
        
        //set severity levels which can be changed in the future
        let severity:[Severity] = [.extreme,.severe]
        
        //build url and send request
        guard let url = getURLForNWS(location: coordinate, severity: severity) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                completion(nil,error)
                return
            }
            guard let data = data else {
                completion(nil,DecodingError.invalidResponse)
                return
            }
            
            do{
                let response = try JSONDecoder().decode(NWSResponse.self, from: data)
                completion(response.features,nil)
                return
            } catch {
                completion(nil,error)
                return
            }
            
            }.resume()
        
    }
    
    //builds url for URLRequest. written with future changes to severity in mind
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
            updateWithLocation(demo: true)
        }
    }
    
    private let severityRating = [ "none": (rating: 0, color: UIColor(red: 11.0/255.0, green: 102.0/255.0, blue: 35.0/255.0, alpha: 1.0)),
                                   "minor": (rating: 1, color: UIColor.green),
                                   "moderate" : (rating: 2, color: UIColor.yellow),
                                   "severe" : (rating: 3, color: UIColor.orange),
                                   "extreme" : (rating: 4, color: UIColor.red)]
    
    
    private var offers = [Offer]()
    private var requests = [Request]()
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
}
