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
        
        // Check which data to populate collection view.
        checkDataSource()
        
        offerSegmentedControl.backgroundColor = .clear
        offerSegmentedControl.tintColor = .clear
        offerSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        offerSegmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.011998998, green: 0.4799926877, blue: 1, alpha: 1)  // #colorLiteral(red: 0.9342113733, green: 0.7635644078, blue: 0.07422252744, alpha: 1)
            ], for: .selected)
    }
    
    @IBAction func selectSegmentControl(_ sender: Any) {
        checkDataSource()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "AddOffer" {
//            
//        } else if segue.identifier == "EditOffer" {
//            
//        } else if segue.identifier == "ViewOffer" {
//            
//        }
//        if let destinationVC = segue.destination as? AddEditBusinessOfferViewController {
//            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
//                destinationVC.offer = offers[indexPath.row]
//            }
//            
//        } else if let destinationVC = segue.destination as? BusinessOfferDetailViewController {
//            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
//                destinationVC.offer = offers[indexPath.row]
//            }
//        }
        
        if segue.identifier == "ViewOffer" {
            guard let destinationVC = segue.destination as? BusinessOfferDetailViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            
            destinationVC.offer = self.offers[indexPath.row]
        } else if segue.identifier == "EditOffer" {
            guard let destinationVC = segue.destination as? AddEditBusinessOfferViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            
            destinationVC.offer = self.offers[indexPath.row]
        } else if segue.identifier == "AddOffer" {
            guard let destinationVC = segue.destination as? AddEditBusinessOfferViewController else { return }
            
            destinationVC.offer = nil
        }
    }
    
    
    
    private func checkDataSource() {
        switch offerSegmentedControl.selectedSegmentIndex {
        case 0:
            loadMyOffers()
        case 1:
            loadAllOffers()
        default:
            break
        }
    }
    
    private func loadMyOffers() {
        loadAllOffers()
    }
    
    private func loadAllOffers() {
        
//        let username = "RLO1NRW0294WVX9P2NTK21Yu_iX7wU8EkF7ZhSMvyhnmF2Qms"
//        let password = "65n86cBp8FZhvxu0mnITUo"
//        let loginString = String(format: "%@:%@", username, password)
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//        
//        let url = URL(string: "https://sandbox.api.visa.com/vmorc/offers/v1/byfilter")!
//        
//        var request = URLRequest(url: url)
//        
//        request.httpMethod = "GET"
//        request.addValue("Accept", forHTTPHeaderField: "application/json")
//        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//        // TODO: {base64 encoded userid:password}
//        
//        
//        // Pass origin and radius in the http body
//        
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            
//            if let error = error {
//                NSLog("Error getting offers: \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                NSLog("Error getting offers data: \(NSError())")
//                return
//            }
//            
//            do {
//                print("here")
//                let convertedString = String(data: data, encoding: String.Encoding.utf8)
//                print(convertedString)
//                let offerResult = try JSONDecoder().decode(OfferRepresentations.self, from: data)
//                for offerRep in offerResult.offerRepresentations {
//                    // TODO: Should it ignore the current location? or my offers?
//                    
//                    let offer = Offer(offerRepresentation: offerRep)
//                    self.offers.append(offer)
//                }
//            } catch {
//                NSLog("Error decoding offer representations: \(error)")
//            }
//            
//        }.resume()
        
//        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/offers.json")!
//
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//
//            if let error = error {
//                NSLog("Error getting offers: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                NSLog("Error getting offers data: \(NSError())")
//                return
//            }
//
//            do {
//
//                                let convertedString = String(data: data, encoding: String.Encoding.utf8)
//                                print(convertedString!)
//                let offerResult = try JSONDecoder().decode([String: Offer].self, from: data)
//
//                //print(offerResult)
//                self.offers = offerResult.compactMap({ $0.value })
//            } catch {
//                NSLog("Error decoding offer representations: \(error)")
//            }
//
//        }.resume()
        
        let url = URL(string: "https://smallbusinesshackathon.firebaseio.com/offers.json")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error getting offers: \(error)")
                return
            }
            
            //            guard let data = data else {
            //                NSLog("Error getting offers data: \(NSError())")
            //                return
            //            }
            
            //begin demo Code
            
            guard let url = Bundle.main.url(forResource: "demoOfferData", withExtension: "json") else {return}
            
            
            do {
                let demoData = try Data(contentsOf: url)
                //                                let convertedString = String(data: demoData, encoding: String.Encoding.utf8)
                //                                print(convertedString!)
                //
                let offerResult = try JSONDecoder().decode(Response.self, from: demoData)
                let offers = offerResult.offers
                //                print(offerResult)
                //                self.offers = offerResult.compactMap({ $0.value })
                self.offers = offers.compactMap({ $0})
                //                self.offers = offers
                
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OfferCollectionViewCell
        
        cell.offer = offers[indexPath.row]
        cell.contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.contentView.layer.cornerRadius = 20
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch offerSegmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "EditOffer", sender: self)
        case 1:
            performSegue(withIdentifier: "ViewOffer", sender: self)
        default:
            break
        }
    }
    
    // MARK - Properties
    
    private var offers: [Offer] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var offerSegmentedControl: UISegmentedControl!
}
