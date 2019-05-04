//
//  Business.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation
import MapKit

class Business:NSObject, MKAnnotation{
    let name: String
    let phoneNumber: String
    let address: String
    let openStatus: Bool
    let owner: String
    
    var coordinate: CLLocationCoordinate2D {
        var location = CLLocationCoordinate2D()
        CLGeocoder().geocodeAddressString(address) { (results, _) in
            guard let coordinates = results?.first?.location?.coordinate else {return}
            location = coordinates
        }
        return location
    }
    var title: String?{
        return name
    }
    
    init(name: String, phoneNumber: String, address: String, openStatus: Bool, owner: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.openStatus = openStatus
        self.owner = owner
    }
}

