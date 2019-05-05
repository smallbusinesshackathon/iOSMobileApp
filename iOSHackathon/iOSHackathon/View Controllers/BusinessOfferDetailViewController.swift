//
//  BusinessOfferDetailViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class BusinessOfferDetailViewController: UIViewController {
    
    
    @IBOutlet weak var offerValidtoDateLabel: UILabel!
    @IBOutlet weak var offerShareTitleLabel: UILabel!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    @IBOutlet weak var offerRedemptionCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func updateViews() {
        guard let offer = offer else { return }
        
        offerValidtoDateLabel.text = offer.validityToDate
        offerShareTitleLabel.text = offer.shareTitle
        offerDescriptionTextView.text = "\(offer.offerShortDescription)"
        offerRedemptionCodeLabel.text = offer.redemptionCode
        
        
    }

    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }

}
