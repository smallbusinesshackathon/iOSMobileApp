//
//  NWSResponse.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import Foundation

struct NWSResponse: Decodable{
    let features: [WeatherAlert]
}
