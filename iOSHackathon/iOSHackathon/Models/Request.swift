//
//  Requests.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation
import MapKit


class Request: NSObject, MKAnnotation {
    
    var title: String?
    var requestDescription: String
    var category: String
    var address: String
    var caseStatus: Bool
    var responder: String?
    
    var coordinate: CLLocationCoordinate2D {
        var location = CLLocationCoordinate2D()
        CLGeocoder().geocodeAddressString(address) { (results, _) in
            guard let coordinates = results?.first?.location?.coordinate else {return}
            location = coordinates
        }
        return location
    }
    
    init(title: String, requestDescription: String, category: String, address: String, caseStatus: Bool, responder: String) {
        self.title = title
        self.requestDescription = requestDescription
        self.category = category
        self.address = address
        self.caseStatus = caseStatus
        self.responder = responder
    }

}
