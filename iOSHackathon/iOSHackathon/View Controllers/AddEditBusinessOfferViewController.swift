//
//  AddEditBusinessOfferViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class AddEditBusinessOfferViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func addUpdateOffer(_ sender: Any) {
        
        guard let offerTitle = offerTitleTextField.text,
            let offerDescription = offerDescriptionTextView.text else { return}
        
        if let offer = offer {
            // UPDATE REQUEST
            postOffer(title: offerTitle, description: offerDescription, id: offer.offerId)
            
        } else {
            // POST REQUEST
            postOffer(title: offerTitle, description: offerDescription)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateViews() {
        guard let offer = offer else {
            return
        }
        
        offerTitleTextField.text = offer.offerTitle
        offerDescriptionTextView.text = offer.offerShortDescription.text
    }
    
    private func postOffer(title: String, description: String, id: Int = UUID().hashValue) {
        let offer = Offer(title: title, description: description, id: id)
        
        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/offers")!.appendingPathComponent("\(offer.offerId)").appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody =  try JSONEncoder().encode(offer)
        } catch {
            NSLog("Error encoding offer: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error putting offer: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            print(data)
            
        }.resume()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var offerTitleTextField: UITextField!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    
}
