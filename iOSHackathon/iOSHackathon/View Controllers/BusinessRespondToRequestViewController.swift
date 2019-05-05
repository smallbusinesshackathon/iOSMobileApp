//
//  BusinessRespondToRequestViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class BusinessRespondToRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        guard let request = request else { return }
        
        if request.category == "finance" {
            financeStackView.isHidden = false
        }
        
        titleLabel.text = request.title
        descriptionLabel.text = request.requestDescription
        dateLabel.text = request.date.dateFormatter()
        categoryLabel.text = request.category
        addressLabel.text = request.address
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func respondToRequest(_ sender: Any) {
        // POP UP WINDOW?
        
    }
    
    var request: Request? {
        didSet {
            guard isViewLoaded else { return }
            updateViews()
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var financeStackView: UIStackView!
    
}
