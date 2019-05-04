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
        
        //        curl -X GET "https://shared-sandbox-api.marqeta.com/v3/acceptedcountries?count=5&start_index=0&sort_by=-lastModifiedTime" -H "accept: application/json" -H "Authorization: Basic dXNlcjYyOTMxNTU2OTM2MzY5OmI1ZmRiYmFiLTAzYjAtNDBhMi1iNmRhLWEyYmJjZDE0NjEyZQ=="
        
        let url = URL(string: "https://shared-sandbox-api.marqeta.com/v3/acceptedcountries?count=5&start_index=0&sort_by=-lastModifiedTime")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("accept", forHTTPHeaderField: "application/json")
        request.addValue("Authorization", forHTTPHeaderField: "Basic dXNlcjYyOTMxNTU2OTM2MzY5OmI1ZmRiYmFiLTAzYjAtNDBhMi1iNmRhLWEyYmJjZDE0NjEyZQ==")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting offers: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error getting offers data: \(NSError())")
                return
            }
            
            do {
                // let offersResult = JSONDecoder().decode(Offer.self, from: data)
            } catch {
                
            }
            
        }

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
