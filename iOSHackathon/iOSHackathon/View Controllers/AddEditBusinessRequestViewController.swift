//
//  AddEditBusinessRequestViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class AddEditBusinessRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createUpdateRequest(_ sender: Any) {
        
        guard let requestTitle = requestTitleTextField.text,
            let requestDescription = requestDescriptionTextView.text else { return}
        
        if request != nil {
            // UPDATE REQUEST
            
        } else {
            // POST REQUEST
            postRequest(title: requestTitle, description: requestDescription)
        }
    }
    
    private func loadRequest() {
        guard let request = request else {return}
        
        requestTitleTextField.text = request.title
        requestDescriptionTextView.text = request.description
    }
    
    private func putRequest(helpRequest: Request) {
        
    }
    
    private func postRequest(title: String, description: String) {
        
        let helpRequest = Request(title: title, requestDescription: description, category: "labor", address: "address", date: Date(), caseStatus: true, id: UUID())
        
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
    
    @IBOutlet weak var requestTitleTextField: UITextField!
    @IBOutlet weak var requestDescriptionTextView: UITextView!
}
