//
//  BusinessLoginViewController.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import UIKit

class BusinessLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAppearance()
    }
    
    @IBAction func buttonClick(sender: UIButton) {
        let username = "35C9vt7T2"
        let transactionKey = "9GxM2nU34267zw6Z"
        
        let url = URL(string: "https://apitest.authorize.net/xml/v1/request.api")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        //request.addValue("accept", forHTTPHeaderField: "application/json")
        
        let json: [String: Any] = ["authenticateTestRequest": ["merchantAuthentication": ["name": username, "transactionKey": transactionKey]]]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            NSLog("\(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting offers: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error getting offers data: \(NSError())")
                return
            }
            
            let convertedString = String(data: data, encoding: String.Encoding.utf8)
            print(convertedString!)
            
            let alertController = UIAlertController(title: "Success", message: "Merchant verified.", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ViewTabBar", sender: self)
                }
            })
            
            alertController.addAction(alertAction)
            
            DispatchQueue.main.async {
                self.present(alertController, animated: true)
            }
        }.resume()
        
    }
    
    // MARK - Private Methods
    
    private func setUpAppearance() {
        signInButton.layer.cornerRadius = 5
    }
    
    // MARK - Properties
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var businessNameInput: UITextField!
    @IBOutlet weak var businessPhoneNumInput: UITextField!
}
