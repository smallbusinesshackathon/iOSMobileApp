//
//  Enums.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import Foundation
import MapKit

enum Severity:String {
    case minor
    case moderate
    case severe
    case extreme
}

enum DecodingError: Error{
    case invalidResponse
}

let severityRating = ["minor": (rating: 0, color: UIColor.green),
                      "moderate" : (rating: 1, color: UIColor.yellow),
                      "severe" : (rating: 2, color: UIColor.orange),
                      "extreme" : (rating: 3, color: UIColor.red)]
