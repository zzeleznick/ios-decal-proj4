//
//  Restaurant.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/24/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import MapKit

class BusinessLocation: CustomStringConvertible {
    
    var address: String
    var city: String
    var state: String // could use enum
    var zipCode: String
    var zipExtension: String?
    var zipCodeString: String
    
    init(address: String, city: String, state: String,
        zipCode: String, zipExtension: String?) {
        self.address = address
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.zipExtension = zipExtension
        self.zipCodeString = "\(self.zipCode)"
        if let ext = zipExtension {
            zipCodeString = "\(self.zipCode)-\(ext)"
        }
    }
    
    var description: String {
        let tmp = ["Address: \(self.address)",
            "City:  \(self.city)",
            "State:  \(self.state)",
            "Zipcode:  \(self.zipCodeString)",
            ].joinWithSeparator(", ")
        let out = "BusinessLocation{\(tmp)}"
        return out
    }

}
class Restaurant: CustomStringConvertible {
    let randID = String.random(32)
    
    var name: String
    var businessLocation: BusinessLocation
    
    var phoneNumber: String?
    var website: String?
    
    var location: CLLocation
    
    init(name:String, businessLocation: BusinessLocation, phoneNumber: String? = nil, website: String? = nil) {
        self.name = name
        self.businessLocation = businessLocation
        self.location = CLLocation(latitude: CLLocationDegrees(127.0),
            longitude: CLLocationDegrees(127.0))
    }
    
    lazy var dict: [String:String] = {
        [unowned self] in
        let out = ["Restaurant": self.name,
            ]
        return out }()
    
    var description: String {
        let biz = self.businessLocation
        let tmp = ["Name : \(self.name)",
            "Address: \(biz.address)",
            "City:  \(biz.city)",
            "State:  \(biz.state)",
            "Zipcode:  \(biz.zipCodeString)",
            ].joinWithSeparator(", ")
        let out = "Restaurant{\(tmp)}"
        return out
    }
}

func generateSampleRestaurants() -> [Restaurant] {
    let names = ["Flying Dutchhman", "Irish Dubliner", "Bob's Burgers",
                 "Caffe Organica", "Le Petite Bite", "Cafe Milan"]
    let addresses = ["2258 Haste St", "2190 Haste St", "2054 Durant Ave",
        "2050 Durant Ave", "1950 Durant Ave", "1600 Telegraph Ave"]
    let city = "Berkeley"
    let state = "CA"
    let zipCode = "94704"
    var out = [Restaurant]()
    for i in 0..<names.count {
        let location = BusinessLocation(address: addresses[i], city: city, state: state, zipCode: zipCode, zipExtension: nil)
        out.append(Restaurant(name: names[i], businessLocation: location))
    }
    return out
}