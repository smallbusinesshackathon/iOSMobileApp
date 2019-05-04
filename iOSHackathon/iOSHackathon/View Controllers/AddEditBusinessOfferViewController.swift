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

    }
    
    @IBAction func addUpdateOffer(_ sender: Any) {
        
        guard let offerTitle = offerTitleTextField.text,
            let offerDescription = offerDescriptionTextView.text else { return}
        
        if offer != nil {
            // UPDATE REQUEST
            
        } else {
            // POST REQUEST
            postOffer(title: offerTitle, description: offerDescription)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func postOffer(title: String, description: String) {
        let offer = Offer(title: title, description: description)
        
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK - Properties
    
    var offer: Offer?
    
    @IBOutlet weak var offerTitleTextField: UITextField!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    
}
