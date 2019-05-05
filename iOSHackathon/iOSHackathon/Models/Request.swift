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
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    

    init(title: String, requestDescription: String, category: String, address: String, date: Date, caseStatus: Bool, id: UUID, latitude: Double, longitude: Double){
        self.title = title
        self.requestDescription = requestDescription
        self.category = category
        self.address = address
        self.date = date
        self.caseStatus = caseStatus
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
}


