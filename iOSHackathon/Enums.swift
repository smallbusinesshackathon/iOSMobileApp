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

enum AnnotationType: String {
    case request
    case offer
}

enum DemoJson: String {
    case WV = "flashfloodWVandSWVa"
    case TX = "severeThunderstormGalvestonTX"
    case FL = "specialWeatherWakullaFL"
}
