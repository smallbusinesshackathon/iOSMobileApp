//
//  Offer.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation
import MapKit


struct Response: Codable{
    var offers: [Offer]
}

class Offer: NSObject, MKAnnotation, Codable {
    var offerId: Int
    var activeIndicator: Bool
    var merchantList: [Merchant]
    var offerTitle: String
    var validityToDate: String
    var validityFromDate: String
    var shareTitle:String
    var redemptionCode: String
    var offerShortDescription: ShortDescription?
    
    struct ShortDescription: Codable{
        var text:String
    }
    
    var coordinate: CLLocationCoordinate2D {
        let latitude = merchantList[0].merchantAddress[0].latitude
        let longitude = merchantList[0].merchantAddress[0].longitude
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct Merchant: Codable {
        var merchantID: Int?
        var merchant: String?
        var merchantAddress: [MerchantAddress]
        
        struct MerchantAddress: Codable{
            var address1: String
            var latitude: Double
            var longitude: Double
        }
    }

    init(title: String, description: String, id: Int) {
        offerId = 0
        activeIndicator = true
        merchantList = []
        offerTitle = ""
        validityToDate = ""
        validityFromDate = ""
        shareTitle = ""
        offerShortDescription = ShortDescription(text: "")
        redemptionCode = ""
        self.merchantList = []
        
        
    }
    
}
