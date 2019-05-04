//
//  Business.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation

class Business{
    let name: String
    let phoneNumber: String
    let address: String
    let openStatus: Bool
    let owner: String
    init(name: String, phoneNumber: String, address: String, openStatus: Bool, owner: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.openStatus = openStatus
        self.owner = owner
    }
}

