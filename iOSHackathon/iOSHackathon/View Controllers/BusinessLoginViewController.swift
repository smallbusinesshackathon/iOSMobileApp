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
    
    // Sign in functionality.
    @IBAction func buttonClick(sender: UIButton) {
        guard let username = usernameInput.text,
            let transactionKey = passwordInput.text else { return }
        
        let url = URL(string: "https://apitest.authorize.net/xml/v1/request.api")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
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
    
    // Set up any specific UI elements outside of general setTheme().
    private func setUpAppearance() {
        Appearance.setUpBlueButton(button: signInButton)
    }
    
    // MARK - Properties
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
}
