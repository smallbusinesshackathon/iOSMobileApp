//
//  BusinessSettingsViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/8/19.
//

import UIKit

class BusinessSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK - Private Methods
    
    private func setUpAppearance() {
        Appearance.setUpBlueButton(button: submitChangesButton)
    }
    
    // MARK - Properties
    
    @IBOutlet weak var submitChangesButton: UIButton!
    
}
