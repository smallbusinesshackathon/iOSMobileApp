//
//  Offers.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation


struct Offers: Codable {
    let offers: [Offer]
    
    enum CodingKeys: String, CodingKey {
        case offers = "Offers"
        
    }
}

struct Offer: Codable {
    let offerId: Int
    let activeIndicator, soldOut: Bool
    let lastModifiedDatetime: String
    //let programID: Int
    //let programName: String
    //let languageID: Int
    //let language: String
    let merchantList: [MerchantList]
    let offerTitle: String
    let featuredOfferIndicator: Bool
    let validityFromDate, validityToDate: String
    //let promotionChannelList, socialMediaSharingTypes: [BusinessSegmentList]
    let shareTitle: String
    //let redemptionChannelList: [BusinessSegmentList]
    //let promotionRestrictions: FAQs
    //let isOfferEvent: Bool
    //let eventSubTitle: String
    //let dateLocations: [JSONAny]
    let offerShortDescription, offerCopy, merchantTerms: FAQs
   // let visaTerms, fAQs, redemptionTelephone: FAQs
    let redemptionCode: String
    let imageList: [ImageList]
    let barcode: String?
    //let redemptionFormatInstructions: String
    let qrCode: String?
    //let offerSource, offerSourceContact: String
    // payments? let redemptionCountries, promotingCountries, cardProductList, cardPaymentTypeList: [BusinessSegmentList]
    //let businessSegmentList: [BusinessSegmentList]
    let categorySubcategoryList: [CategorySubcategoryList]
    //let offerType: [BusinessSegmentList]
    //let creativeApprovalsEmail, creativeGuidelines: String
    //let bins, rpins, binstorpins, accountranges: [JSONAny]
    //let accountrangestorpins, offerMetadata: [JSONAny]
    //let supData1, supData2, supData3, supData4: FAQs
    
    enum CodingKeys: String, CodingKey {
        //case indexNumber
        //case offerContentID = "offerContentId"
        case offerID = "offerId"
        case activeIndicator, soldOut, lastModifiedDatetime, merchantList, offerTitle, featuredOfferIndicator, validityFromDate, validityToDate, shareTitle, offerShortDescription, offerCopy, merchantTerms, redemptionCode, imageList, barcode, qrCode, categorySubcategoryList
    }
}

struct CategorySubcategoryList: Codable {
    //let key: Int
    let value: String
}

struct FAQs: Codable {
    let text: String
}

struct ImageList: Codable {
    //let key: Int
    //let imageResolution, description: String
    let fileLocation: String
   // let imageFileSize, imageFileHeight, imageFileWidth: String
    //let offerImagePromotionChannels: [String]
   // let offerImagePromotionChannelIDS: [Int]
    //let imageAltTag: String
    
    enum CodingKeys: String, CodingKey {
        case fileLocation
    }
}

struct MerchantList: Codable {
    let merchantID: Int
    let merchant: String
    let merchantAddress: [JSONAny]
    let merchantImages: [MerchantImage]
    
    enum CodingKeys: String, CodingKey {
        case merchantID = "merchantId"
        case merchant, merchantAddress, merchantImages
    }
}

struct MerchantImage: Codable {
    //let key: Int
    //let fileName: String
    //let promotionID: Int
    let promotionChannel: String
    //let promotionIDS: [Int]
    let promotionChannels: [String]
    let fileLocation: String?
    //let defaultMerchImg: Bool
    //let imageFileSize, imageFileHeight, imageFileWidth: String
    //let languageIDS: [Int]
    //let languages: [String]
    //let logoAltTag: String
    
    enum CodingKeys: String, CodingKey {
       // case key, fileName, imageResolution, description
       // case promotionID = "promotionId"
        case promotionChannel
       // case promotionIDS = "promotionIds"
        case promotionChannels, fileLocation
        //case languageIDS = "languageIds"
       // case languages, logoAltTag
    }
}

// MARK: Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
