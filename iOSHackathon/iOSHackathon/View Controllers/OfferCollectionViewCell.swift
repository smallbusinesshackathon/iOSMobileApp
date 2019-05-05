//
//  OfferCollectionViewCell.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerMerchantNameLabel: UILabel!
    @IBOutlet weak var offerLocationLabel: UILabel!
    @IBOutlet weak var offerActiveIndicatorLabel: UILabel!
    
    private func updateViews() {
        guard let offer = offer else { return }
        
        offerTitleLabel.text = offer.offerTitle
        offerMerchantNameLabel.text = "\(offer.merchantList.first?.merchant ?? "Local Works")"
        
        if let address = offer.merchantList.first?.merchantAddress.first {
            offerLocationLabel.text = "\(address)"
        } else {
            offerLocationLabel.text = "123 Main St"
        }
        if offer.activeIndicator == true {
            offerActiveIndicatorLabel.text = "Active"
        } else {
            offerActiveIndicatorLabel.text = "Inactive"
        }
        
        
    }
    
    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }
}

