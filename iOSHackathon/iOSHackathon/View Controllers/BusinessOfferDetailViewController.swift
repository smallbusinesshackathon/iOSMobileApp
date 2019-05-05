//
//  BusinessOfferDetailViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class BusinessOfferDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func updateViews() {
        guard let offer = offer else { return }
        
        
    }

    // MARK - Properties
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }

}
