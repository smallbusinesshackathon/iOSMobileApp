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
        setUpAppearance()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addUpdateOffer(_ sender: Any) {
        guard let offTitle = offerTitleTextField.text,
        let offDescription = offerDescriptionTextView.text,
        let offLocation = offerLocationTextField.text,
        let offRedemptionCode = offerRedemptionCodeTextField.text,
            let offShareTitle = offerTitleTextField.text else { return }
        

        let offEndDate = offerEndDatePicker.date

        let id = 0
        
        if offer != nil {
            // UPDATE REQUEST
            
            
        } else {
            // POST REQUEST
            //postOffer(title: offTitle, description: offDescription, id: id, merchantName: offMerchantName, location: offLocation, redemptionCode: offRedemptionCode, shareTitle: offShareTitle, activeIndicator: offActiveIndicator, startDate: offStartDate, endDate: offEndDate)
        }
    }
    
    // MARK - Private Methods
    
    private func updateViews() {
        guard let offer = offer else { return}
        
        viewTitleLabel.text = "Edit offer"
        
        offerTitleTextField.text = offer.offerTitle
        offerDescriptionTextView.text = offer.offerShortDescription?.text
        offerLocationTextField.text = offer.merchantList.first?.merchantAddress.first?.address1
        offerRedemptionCodeTextField.text = offer.redemptionCode
        //offerStartDatePicker.date = offer.validityFromDate
        //offerEndDatePicker.date = offer.validityToDate
    }
    

    private func setUpAppearance() {
        Appearance.styleTextView(textView: offerDescriptionTextView)
        Appearance.setUpBlueButton(button: submitButton)
    }

    private func postOffer(title: String, description: String, id: Int, merchantName: String, location: String, redemptionCode: String, shareTitle: String, activeIndicator: Bool, startDate: String, endDate: String) {
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
            guard isViewLoaded else { return }
            updateViews()
        }
    }
    
    @IBOutlet weak var offerTitleTextField: UITextField!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    @IBOutlet weak var offerLocationTextField: UITextField!
    @IBOutlet weak var offerRedemptionCodeTextField: UITextField!
    @IBOutlet weak var offerEndDatePicker: UIDatePicker!
    @IBOutlet weak var viewTitleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
}



