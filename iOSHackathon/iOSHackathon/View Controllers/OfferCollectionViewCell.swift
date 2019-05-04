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
        
        titleLabel.text = offer.offerTitle
    }
    
    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
}
