//
//  Request.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation
import MapKit

class Request: NSObject, MKAnnotation, Codable {
    
    var title: String?
    var requestDescription: String
    var category: String
    var address: String
    var date: Date
    var caseStatus: Bool
    var id: UUID
    
    var coordinate: CLLocationCoordinate2D {
        var location = CLLocationCoordinate2D()
        CLGeocoder().geocodeAddressString(address) { (results, _) in
            guard let coordinates = results?.first?.location?.coordinate else {return}
            location = coordinates
        }
        return location
    }
    
    init(title: String, requestDescription: String, category: String, address: String, date: Date, caseStatus: Bool, id: UUID) {
        self.title = title
        self.requestDescription = requestDescription
        self.category = category
        self.address = address
        self.date = date
        self.caseStatus = caseStatus
        self.id = id
    }

}
   
