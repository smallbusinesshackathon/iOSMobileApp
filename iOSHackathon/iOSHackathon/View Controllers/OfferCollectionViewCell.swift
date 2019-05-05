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
    
    
//    private func updateViews() {
//        guard let request = request else { return }
//
//        titleLabel.text = request.title
//        requestDescriptionLabel.text = request.requestDescription
//        categoryLabel.text = request.category
//        addressLabel.text = request.address
//        dateLabel.text = "\(request.date.dateFormatter())"
//        if request.caseStatus {
//            caseStatusLabel.text = "Pending"
//        } else {
//            caseStatusLabel.text = "Closed"
//        }
//
//    }
    
    
    private func updateViews() {
        guard let offer = offer else { return }
        
        offerTitleLabel.text = offer.offerTitle
        offerMerchantNameLabel.text = "\(offer.merchantList)"
        offerLocationLabel.text = "\(offer.merchantList)"
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

