//
//  Extensions.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import Foundation
import UIKit
import MapKit


extension Date{
    func dateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
//        let date = Date(timeIntervalSinceReferenceDate: 118800)
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}

extension Request: HelpAnnotation{
    var type: AnnotationType {
        get {
           return .request
        }
    }
    
    
}

extension Offer: HelpAnnotation{
    var type: AnnotationType {
        get {
            return .offer
        }
    }
}

extension UIColor{
    static let darkGreen = UIColor(red: 11.0/255.0, green: 102.0/255.0, blue: 35.0/255.0, alpha: 1.0)
}

