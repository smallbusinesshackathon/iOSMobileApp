//
//  OfferCollectionViewCell.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {
    
    private func updateViews() {
        guard let offer = offer else { return }
        
        offerTitleLabel.text = offer.offerTitle
        offerMerchantNameLabel.text = "\(offer.merchantList.first?.merchant ?? "Local Gardens")"
        offerLocationLabel.text = offer.merchantList.first?.merchantAddress.first?.address1 ?? "123 Main St"
        if offer.activeIndicator == true {
            offerActiveIndicatorLabel.text = "Active"
        } else {
            offerActiveIndicatorLabel.text = "Inactive"
        }
        descriptionLabel.text = offer.offerShortDescription?.text ?? "Check it out!"
        
    }
    
    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerMerchantNameLabel: UILabel!
    @IBOutlet weak var offerLocationLabel: UILabel!
    @IBOutlet weak var offerActiveIndicatorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

