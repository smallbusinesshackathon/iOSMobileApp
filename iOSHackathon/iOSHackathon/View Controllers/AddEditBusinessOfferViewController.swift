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
        
        //updateViews()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var offerTitleTextField: UITextField!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    @IBOutlet weak var offerMerchantNameTextField: UITextField!
    @IBOutlet weak var offerLocationTextField: UITextField!
    @IBOutlet weak var offerRedemptionCodeTextField: UITextField!
    @IBOutlet weak var offerShareTitleTextField: UITextField!
    @IBOutlet weak var offerStartDatePicker: UIDatePicker!
    @IBOutlet weak var offerEndDatePicker: UIDatePicker!
    @IBOutlet weak var offerActiveIndicator: UISwitch!
    
    @IBAction func addUpdateOffer(_ sender: Any) {
        guard let offTitle = offerTitleTextField.text,
        let offDescription = offerDescriptionTextView.text,
        let offMerchantName = offerMerchantNameTextField.text,
        let offLocation = offerLocationTextField.text,
        let offRedemptionCode = offerRedemptionCodeTextField.text,
        let offShareTitle = offerShareTitleTextField.text else { return}
        
        let offStartDate = offerStartDatePicker.date
        let offEndDate = offerEndDatePicker.date
        let offActiveIndicator = offerActiveIndicator.isOn
        let id = 0
        
        if offer != nil {
            // UPDATE REQUEST
            
            
        } else {
            // POST REQUEST
            postOffer(title: offTitle, description: offDescription, id: id, merchantName: offMerchantName, location: offLocation, redemptionCode: offRedemptionCode, shareTitle: offShareTitle, activeIndicator: offActiveIndicator, startDate: offStartDate, endDate: offEndDate)
        }
    }
    
    
    
    
    
    private func updateViews() {
        guard let offer = offer else { return}
        
        offerTitleTextField.text = offer.offerTitle
        offerDescriptionTextView.text = offer.offerShortDescription?.text
        offerMerchantNameTextField.text = offer.merchantList.first?.merchant
        offerLocationTextField.text = offer.merchantList.first?.merchantAddress.first
        offerRedemptionCodeTextField.text = offer.redemptionCode
        offerShareTitleTextField.text = offer.shareTitle
        //offerStartDatePicker.date = offer.validityFromDate
        //offerEndDatePicker.date = offer.validityToDate
        offerActiveIndicator.isOn = offer.activeIndicator
    }
    
    private func postOffer(title: String, description: String, id: Int, merchantName: String, location: String, redemptionCode: String, shareTitle: String, activeIndicator: Bool, startDate: Date, endDate: Date) {
        let offer = Offer(title: title, description: description, id: id, merchantName: merchantName, merchantLocation: location, redemptionCode: redemptionCode, shareTitle: shareTitle, activeIndicator: activeIndicator, startDate: startDate, endDate: endDate)
        
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
    
    
    
}



