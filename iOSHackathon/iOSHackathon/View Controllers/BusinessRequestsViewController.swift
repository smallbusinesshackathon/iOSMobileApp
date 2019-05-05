//
//  BusinessRequestsViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class BusinessRequestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCell", for: indexPath) as! RequestCollectionViewCell
        
        cell.request = requests[indexPath.row]
        cell.contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.contentView.layer.cornerRadius = 20
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check which data to populate collection view.
        checkDataSource()
        
        requestSegmentedControl.backgroundColor = .clear
        requestSegmentedControl.tintColor = .clear
        requestSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        requestSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.011998998, green: 0.4799926877, blue: 1, alpha: 1)  // #colorLiteral(red: 0.9342113733, green: 0.7635644078, blue: 0.07422252744, alpha: 1)
            ], for: .selected)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
                self.requests.append(array.first!)
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
