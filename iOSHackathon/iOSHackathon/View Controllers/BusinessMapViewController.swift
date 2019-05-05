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
        
        updateAlertLabel(alerts: [])
        
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MapAnnotation")
        loadAllOffers() {
            self.mapView.addAnnotations(self.offers)
        }
        loadAllRequests {
            self.mapView.addAnnotations(self.requests)
        }
        
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
        guard let annotation = annotation as? HelpAnnotation else {return nil}
        var color = UIColor.red
        
        if annotation.type == .offer {
            color = UIColor.darkGreen
        }
        
        let dequeued = mapView.dequeueReusableAnnotationView(withIdentifier: "MapAnnotation", for: annotation) as! MKMarkerAnnotationView
        
        dequeued.markerTintColor = color
        dequeued.glyphTintColor = .white
        
        dequeued.canShowCallout = true
        
        //TODO: Implement detailView
        return dequeued
    }
    

    
    
    //MARK: - DEMO functions
    private func demoUpdateWithLocationDC(){
        let location = demoLocationDC
        
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(viewRegion, animated: true)
        
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
    
    private func demoUpdateWithHazard(fileName: DemoJson, coordinates: CLLocationCoordinate2D){
        let location = coordinates
        
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(viewRegion, animated: true)
        
        //Find local alerts
        demoGetAlertFromNWSAPI(fileName: fileName.rawValue){ (results, error) in
            if let error = error {
                NSLog("Error decoding API request: \(error)")
                return
            }
            guard let results = results else {return}
            DispatchQueue.main.async {
                self.updateAlertLabel(alerts: results)
            }
        }
    }
    
    private func demoGetAlertFromNWSAPI(fileName:String, completion:@escaping ([WeatherAlert]?, Error?)->Void){
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {return}
        
        
        do {
            let demoData = try Data(contentsOf: url)
            
            let response = try JSONDecoder().decode(WeatherAlert.self, from: demoData)
            completion([response],nil)
            return
        } catch {
            completion(nil,error)
            return
        }
        
        
        
    }
    
    //MARK: - Private
    private func updateWithLocation(){
        //Zoom to user location
        
        guard let location = location else {return}
        //        let location = demoLocationDC
        
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(viewRegion, animated: true)
        
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
        var backgroundColor = UIColor()
        var labelText = ""
        
        if alerts.isEmpty{
            labelText = "There are no weather alerts in your current area"
            backgroundColor = severityRating["none"]!.color
        } else {
            guard let mostSevere = getMostSevereAlert(alerts: alerts) else {return}
            labelText = "\(mostSevere.severity): \(mostSevere.event)"
            backgroundColor = severityRating[mostSevere.severity.lowercased()]!.color
        }
        alertLabel.text = labelText
        alertView.backgroundColor = backgroundColor
        updateStatusBarColor(color: backgroundColor)
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
    
    private func loadAllOffers(completion:@escaping ()->Void) {
        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/offers.json")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error getting offers: \(error)")
                return
            }
            
            //            guard let data = data else {
            //                NSLog("Error getting offers data: \(NSError())")
            //                return
            //            }
            
            //begin demo Code
            
            guard let url = Bundle.main.url(forResource: "demoOfferData", withExtension: "json") else {return}
            
            
            do {
                let demoData = try Data(contentsOf: url)
                let offerResult = try JSONDecoder().decode(Response.self, from: demoData)
                let offers = offerResult.offers
                self.offers = offers.compactMap({ $0})
                completion()
            } catch {
                NSLog("Error decoding offer representations: \(error)")
            }
            
            }.resume()
        
    }
    
    private func loadAllRequests(completion:@escaping ()->Void) {
        
        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/requests.json")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error getting request: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error getting request data: \(NSError())")
                return
            }
            
            do {
                
                //                let convertedString = String(data: data, encoding: String.Encoding.utf8)
                //                print(convertedString!)
                let requestResult = try JSONDecoder().decode([String: Request].self, from: data)
                
                print(requestResult)
                self.requests = requestResult.compactMap({ $0.value })
                completion()
            } catch {
                NSLog("Error decoding requests: \(error)")
            }
            
            }.resume()
        
    }
    
    //MARK: - Properties
    private var locationManager  = CLLocationManager()
    private var location: CLLocationCoordinate2D? {
        didSet{
//            updateWithLocation()
//            demoUpdateWithLocationDC()
            demoUpdateWithHazard(fileName: .TX, coordinates: CLLocationCoordinate2D(latitude: 29.300131, longitude: -94.795853))
        }
    }
    
    private let severityRating = [ "none": (rating: 0, color: UIColor.darkGreen),
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

