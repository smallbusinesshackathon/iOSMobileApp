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
    }
    
    // MARK - Properties
    
    var request: Request? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
}
