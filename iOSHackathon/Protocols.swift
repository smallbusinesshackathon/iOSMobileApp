//
//  Protocols.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/5/19.
//

import Foundation
import MapKit

protocol HelpAnnotation: MKAnnotation{
    var type: AnnotationType {get}
}
