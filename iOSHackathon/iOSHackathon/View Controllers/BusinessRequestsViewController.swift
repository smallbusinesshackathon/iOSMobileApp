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
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check which data to populate collection view.
        checkDataSource()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddEditBusinessRequestViewController {
            
        } else if let destinationVC = segue.destination as? BusinessRespondToRequestViewController {
            
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
                
                print(requestResult)
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
