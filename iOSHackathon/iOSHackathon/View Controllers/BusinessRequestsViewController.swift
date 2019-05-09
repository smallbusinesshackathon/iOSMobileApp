//
//  BusinessRequestsViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class BusinessRequestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check which data to populate collection view.
        checkDataSource()
    }
    
    // MARK - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCell", for: indexPath) as! RequestCollectionViewCell
        
        cell.request = requests[indexPath.row]
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch requestSegmentedControl.selectedSegmentIndex {
        case 0:
            self.performSegue(withIdentifier: "EditRequest", sender: self)
        case 1:
            self.performSegue(withIdentifier: "ViewRequest", sender: self)
        default:
            break
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ViewRequest" {
            guard let destinationVC = segue.destination as? BusinessRespondToRequestViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            
            destinationVC.request = self.requests[indexPath.row]
        } else if segue.identifier == "EditRequest" {
            guard let destinationVC = segue.destination as? AddEditBusinessRequestViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            
            destinationVC.request = self.requests[indexPath.row]
        } else if segue.identifier == "EditRequest" {
            guard let destinationVC = segue.destination as? AddEditBusinessRequestViewController else { return }
            
            destinationVC.request = nil
        }
    }
    
    @IBAction func selectSegmentedControl(_ sender: Any) {
        checkDataSource()
    }
    
    private func checkDataSource() {
        switch requestSegmentedControl.selectedSegmentIndex {
        case 0:
            loadMyRequests()
        case 1:
            loadAllRequests()
        default:
            break
        }
    }
    
    private func loadMyRequests() {
        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/requests.json")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error getting request: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error getting request data: \(NSError())")
                return
            }
            
            do {
                
                //                let convertedString = String(data: data, encoding: String.Encoding.utf8)
                //                print(convertedString!)
                let requestResult = try JSONDecoder().decode([String: Request].self, from: data)
                
                let array = requestResult.compactMap({ $0.value })
                self.requests = [array.first!]
            } catch {
                NSLog("Error decoding requests: \(error)")
            }
            
        }.resume()
    }
    
    private func loadAllRequests() {
        
        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/requests.json")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error getting request: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error getting request data: \(NSError())")
                return
            }
            
            do {
                
//                let convertedString = String(data: data, encoding: String.Encoding.utf8)
//                print(convertedString!)
                let requestResult = try JSONDecoder().decode([String: Request].self, from: data)
                
                //print(requestResult)
                self.requests = requestResult.compactMap({ $0.value })
            } catch {
                NSLog("Error decoding requests: \(error)")
            }
            
        }.resume()
        
    }

    private var requests: [Request] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var requestSegmentedControl: UISegmentedControl!
    
}
