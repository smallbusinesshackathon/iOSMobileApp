//
//  RequestCollectionViewCell.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class RequestCollectionViewCell: UICollectionViewCell {

    private func updateViews() {
        guard let request = request else { return }
        
        titleLabel.text = request.title
        requestDescriptionLabel.text = request.requestDescription
        categoryLabel.text = request.category
        addressLabel.text = request.address
        dateLabel.text = "\(request.date.dateFormatter())"
        if request.caseStatus {
            caseStatusLabel.text = "Pending"
        } else {
            caseStatusLabel.text = "Closed"
        }
    }
    
    // MARK - Properties
    
    var request: Request? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var requestDescriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var caseStatusLabel: UILabel!
}
