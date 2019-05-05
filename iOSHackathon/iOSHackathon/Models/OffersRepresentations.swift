////
////  Offers.swift
////  iOSHackathon
////
////  Created by Xu Mo on 5/4/19.
////
//
//import Foundation
//
//struct OfferRepresentations: Codable {
//    let offerRepresentations: [OfferRepresentation]
//}
//
//struct OfferRepresentation:  Codable {
//    let offerId: Int
//    let activeIndicator, soldOut: Bool
//    let lastModifiedDatetime: String
//    let merchantList: [MerchantList]
//    let offerTitle: String
//    let featuredOfferIndicator: Bool
//    let validityFromDate, validityToDate: String
//    let shareTitle: String
//    let offerShortDescription, offerCopy, merchantTerms: FAQs
//    let redemptionCode: String
//    let imageList: [ImageList]
//    let barcode: String?
//    let qrCode: String?
//    let categorySubcategoryList: [CategorySubcategoryList]
//}
//
//struct CategorySubcategoryList: Codable {
//    let value: String
//}
//
//struct FAQs: Codable {
//    let text: String
//}
//
//struct ImageList: Codable {
//    let fileLocation: String
//    
//}
//
//struct MerchantList: Codable {
//    let merchantId: Int?
//    let merchant: String?
//    let merchantAddress: [String]?
//    let latitude: Double
//    let longitude: Double
//    let merchantImages: [MerchantImage]?
//    
//}
//
//struct MerchantImage: Codable {
//    let fileLocation: String?
//}
