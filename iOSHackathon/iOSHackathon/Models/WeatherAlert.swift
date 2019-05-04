//
//  WeatherAlert.swift
//  iOSHackathon
//
//  Created by Andrew Dhan on 5/4/19.
//

import Foundation
import MapKit


struct WeatherAlert: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FeatureCodingKeys.self)
        let propertyContainer = try container.nestedContainer(keyedBy: FeatureCodingKeys.PropertiesCodingKeys.self, forKey: .properties)
        
        //Set Weather Alert properties from Property Container
        self.severity = try propertyContainer.decode(String.self, forKey: .severity)
        self.headline = try propertyContainer.decode(String.self, forKey: .headline)
        self.description = try propertyContainer.decode(String.self, forKey: .description)
        self.instruction = try propertyContainer.decode(String.self, forKey: .instruction)
        self.effective = try propertyContainer.decode(String.self, forKey: .effective)
        self.expires = try propertyContainer.decode(String.self, forKey: .expires)
        
        //Set affectedArea property using values from geometryContainer
        let geometryContainer = try container.nestedContainer(keyedBy: FeatureCodingKeys.GeometryCodingKeys.self, forKey: .geometry)
        
        var coordinatesContainer = try geometryContainer.nestedUnkeyedContainer(forKey: .coordinates)
        
        var coordinates = [CLLocationCoordinate2D]()
        
        //Only one set of coordinates is expected or needed so counter is necessary
        
        while !coordinatesContainer.isAtEnd && coordinatesContainer.currentIndex == 0{
            var coordinateContainer = try coordinatesContainer.nestedUnkeyedContainer()
            
            while !coordinateContainer.isAtEnd{
                
                //latLongContainer will be a double of that either represents the lat or the long
                var latLongContainer = try coordinateContainer.nestedUnkeyedContainer()
                
                //create array to store lat long in order
                var coordinateArray = [Double]()
                while !latLongContainer.isAtEnd{
                    let value = try latLongContainer.decode(Double.self)
                    coordinateArray.append(value)
                }
                //create Coordinate and append to coordinate array
                coordinates.append(CLLocationCoordinate2D(latitude: coordinateArray[0], longitude: coordinateArray[1]))
            }
        }
        self.affectedArea = coordinates
        
    }
    
    enum FeatureCodingKeys: String, CodingKey{
        case geometry
        case properties
        
        enum GeometryCodingKeys: String, CodingKey{
            case coordinates
            
        }
        enum PropertiesCodingKeys: String, CodingKey{
            case severity
            case headline
            case description
            case instruction
            case effective
            case expires
        }
    }
    
    let severity: String
    let headline: String
    let description: String
    let instruction: String
    let effective: String
    let expires: String
    var affectedArea: [CLLocationCoordinate2D]?
}
