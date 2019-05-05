//
//  AddEditBusinessRequestViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit
import CoreLocation

class AddEditBusinessRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var requestTitleTextField: UITextField!
    @IBOutlet weak var requestDescriptionTextView: UITextView!
    @IBOutlet weak var requestCategoryTextField: UITextField!
    @IBOutlet weak var requestAddressTextField: UITextField!
    @IBOutlet weak var requestCaseStatusSwitch: UISwitch!
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    
    @IBAction func createUpdateRequest(_ sender: Any) {
        
        guard let requestTitle = requestTitleTextField.text,
            let requestDescription = requestDescriptionTextView.text,
            let requestCategory = requestCategoryTextField.text,
            let requestAddress = requestAddressTextField.text else { return}
        
        let requestCaseStatus = requestCaseStatusSwitch.isOn
        //let requestDate = request?.date
        
        if request != nil {
            // UPDATE REQUEST
            
        } else {
            CLGeocoder().geocodeAddressString(requestAddress) { (placemarks, error) in
                if let error = error {
                    NSLog("Error geocoding address: \(error)")
                    return
                }
                guard let placemark = placemarks?.first,
                let location = placemark.location else {return}
                self.postRequest(title: requestTitle, description: requestDescription, category: requestCategory, address: requestAddress, caseStatus: requestCaseStatus, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
            }
            
            // POST REQUEST

        }
    }
    
    private func loadRequest() {
        guard let request = request else {return}
        
        viewTitleLabel.text = "Edit Request"
        requestTitleTextField.text = request.title
        requestDescriptionTextView.text = request.requestDescription
        requestCategoryTextField.text = request.category
        requestAddressTextField.text = request.address
        requestCaseStatusSwitch.isOn = request.caseStatus
        
    }
    
    private func putRequest(helpRequest: Request) {
        
    }
    
    private func postRequest(title: String, description: String, category: String, address: String, caseStatus: Bool, latitude: Double, longitude: Double) {
        
        let helpRequest = Request(title: title, requestDescription: description, category: category, address: address, date: Date(), caseStatus: caseStatus, id: UUID(),latitude: latitude, longitude: longitude)

        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/requests")!.appendingPathComponent(helpRequest.id.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody =  try JSONEncoder().encode(helpRequest)
        } catch {
            NSLog("Error encoding request: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error putting request: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            print(data)
            
        }.resume()
    }
    
    // MARK - Properties
    
    var request: Request? {
        didSet {
            loadRequest()
        }
    }
    
    
}
