//
//  Offer.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation
import MapKit

class Offer: NSObject{
    var offerId: Int
    var activeIndicator, soldOut: Bool
    var merchantList: [MerchantList]
    var offerTitle: String
    var validityFromDate, validityToDate: String
    var shareTitle: String
    var offerShortDescription, offerCopy, merchantTerms: FAQs
    var redemptionCode: String
    var barcode: String?
    var qrCode: String?
    
    
    init(offerRepresentation: OfferRepresentation) {
        
        offerId = offerRepresentation.offerId
        activeIndicator = offerRepresentation.activeIndicator
        soldOut = offerRepresentation.soldOut
        merchantList = offerRepresentation.merchantList
        offerTitle = offerRepresentation.offerTitle
        validityFromDate = offerRepresentation.validityFromDate
        validityToDate = offerRepresentation.validityToDate
        shareTitle = offerRepresentation.shareTitle
        offerShortDescription = offerRepresentation.offerShortDescription
        offerCopy = offerRepresentation.offerCopy
        merchantTerms = offerRepresentation.merchantTerms
        redemptionCode = offerRepresentation.redemptionCode
        barcode = offerRepresentation.barcode
        qrCode = offerRepresentation.qrCode
        
    
    }
    
}
