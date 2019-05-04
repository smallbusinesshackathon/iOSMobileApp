//
//  Extensions.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import Foundation

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
