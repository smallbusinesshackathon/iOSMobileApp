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
    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var offerRedemptionCodeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
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
        descriptionLabel.text = offer.offerShortDescription?.text ?? "Check it out!"
        offerRedemptionCodeLabel.text = offer.redemptionCode
        locationLabel.text = offer.merchantList.first?.merchantAddress.first?.address1 ?? "123 Main St"
    }

    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            guard isViewLoaded else { return }
            updateViews()
        }
    }

}
