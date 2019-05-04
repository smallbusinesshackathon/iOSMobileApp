//
//  BusinessLoginViewController.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import UIKit

class BusinessLoginViewController: UIViewController {
    
    
    @IBOutlet weak var businessNameInput: UITextField!
    @IBOutlet weak var businessPhoneNumInput: UITextField!
    @IBOutlet weak var submitBusinessButton: UIButton!

    
    @IBAction func buttonClick(sender: UIButton) {
//        guard let businessName = businessNameInput.text,
//            let businessPhoneNum = businessPhoneNumInput.text else { return }
//
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
