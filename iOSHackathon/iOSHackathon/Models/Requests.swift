//
//  Requests.swift
//  iOSHackathon
//
//  Created by Xu Mo on 5/4/19.
//

import Foundation

class Requests: NSObject{
    
    var title: String
    var requestDescription: String
    var category: String
    var location: String
    var caseStatus: Bool
    var responder: String?
    
    init(title: String, requestDescription: String, category: String, location: String, caseStatus: Bool, responder: String) {
        self.title = title
        self.requestDescription = requestDescription
        self.category = category
        self.location = location
        self.caseStatus = caseStatus
        self.responder = responder
    }

}
    

