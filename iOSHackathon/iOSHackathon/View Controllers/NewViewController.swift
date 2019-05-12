//
//  NewViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/5/19.
//

import UIKit

class NewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let agency = agencies[indexPath.row]
        
        cell.textLabel?.text = agency.legalAgencyName
        
        return cell
    }
    
    // MARK - IBActions
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
    }
    
    @IBAction func loadFEMA(_ sender: Any) {
        
        guard let url = Bundle.main.url(forResource: "fema", withExtension: "json") else { return }
        
        do {
            let demoData = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(Agencies.self, from: demoData)
            self.agencies = result.fema
            
        } catch {
            NSLog("Error decoding fema agencies: \(error)")
        }
    }
    
    // MARK - Properties
    
    var agencies: [Agency] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
}
