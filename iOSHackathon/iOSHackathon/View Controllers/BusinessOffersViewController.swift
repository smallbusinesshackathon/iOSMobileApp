//
//  BusinessOffersViewController.swift
//  iOSHackathon
//
//  Created by Daniela Parra on 5/4/19.
//

import UIKit

class BusinessOffersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch offerSegmentedControl.selectedSegmentIndex {
        case 0:
            loadMyOffers()
        case 1:
            loadAllOffers()
        default:
            break
        }
        
        // Load offers from API
        loadAllOffers()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    private func loadMyOffers() {
        
    }
    
    private func loadAllOffers() {
        
        let url = URL(string: "https://sandbox.api.visa.com/vmorc/offers/v1/byfilter")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Accept", forHTTPHeaderField: "application/json")
        request.addValue("Authorization", forHTTPHeaderField: "Basic dXNlcjYyOTMxNTU2OTM2MzY5OmI1ZmRiYmFiLTAzYjAtNDBhMi1iNmRhLWEyYmJjZDE0NjEyZQ==") // TODO: {base64 encoded userid:password}
        
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
                let offerResult = try JSONDecoder().decode(OfferRepresentations.self, from: data)
                for offerRep in offerResult.offerRepresentations {
                    let offer = Offer(offerRepresentation: offerRep)
                    self.offers.append(offer)
                }
            } catch {
                NSLog("Error decoding offer representations: \(error)")
            }
            
        }.resume()
        
    }

    // MARK - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath)
        
        return cell
    }

    
    // MARK - Properties
    
    private var offers: [Offer] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var offerSegmentedControl: UISegmentedControl!
}
