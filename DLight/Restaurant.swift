//
//  Restaurant.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/24/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class BusinessInfo: CustomStringConvertible {
    let uniqueID = String.random(32)
    var location = CLLocation(latitude: CLLocationDegrees(127.0),
        longitude: CLLocationDegrees(127.0))
    var name: String
    var address: String
    var city: String
    var state: String // could use enum
    var zipCode: String
    var zipExtension: String?
    var zipCodeString: String
    
    init(name: String, address: String, city: String, state: String,
        zipCode: String, zipExtension: String?) {
            self.name = name
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
    lazy var dict: [String:String] = {
        [unowned self] in
        let out = ["Name": self.name,
            "Address": "\(self.address)",
            "City": "\(self.city)",
            "State": "\(self.state)",
            "Zipcode": "\(self.zipCode)",
        ]
        return out }()
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

class Schedule {
    var hours: String!
    init(hours: String? = "9am-9pm") {
        self.hours = hours
    }
}

class Restaurant: CustomStringConvertible {
    var name: String
    var schedule: Schedule
    var menu: Menu
    var businessInfo: BusinessInfo
    var image: UIImage?
    var phoneNumber: String?
    var website: String?
    
    init(businessInfo: BusinessInfo, schedule: Schedule, menu: Menu,
         image: UIImage? = UIImage(named: "placeholder_image"),
         phoneNumber: String? = "None Provided", website: String? = "None Provided") {
        self.businessInfo = businessInfo
        self.name = businessInfo.name
        self.schedule = schedule
        self.menu = menu
        self.image = image
        self.phoneNumber = phoneNumber
        self.website = website
    }
    
    lazy var dict: [String:String] = {
        [unowned self] in
        let out = ["Restaurant": self.name,
            "Hours": "\(self.schedule.hours)",
            "Location": "\(self.businessInfo.address)",
            "Phone Number": "\(self.phoneNumber!)",
            "Website": "\(self.website!)",
            ]
        return out }()
    
    var description: String {
        let biz = self.businessInfo
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
    let names = ["Caffe Organica",  "La Petite Bite", "Cafe Milan", "Flying Dutchhman", "Irish Dubliner", "Bob's Burgers"]
    let imageNames = ["CaffeOrganica", "LaPetiteBite", "CafeMilan",
    "FlyingDutchman", "IrishDubliner", "BobsBurgers"]
    let addresses = ["2258 Haste St", "2190 Haste St", "2054 Durant Ave",
        "2050 Durant Ave", "1950 Durant Ave", "1600 Telegraph Ave"]
    let phone = "510-876-9210"
    let schedule = Schedule()
    let menu = generateSampleMenu()
    var out = [Restaurant]()
    for i in 0..<names.count {
        let business = BusinessInfo(name: names[i], address: addresses[i], city: "Berkeley", state: "CA", zipCode: "94704", zipExtension: nil)
        out.append(Restaurant(businessInfo: business, schedule: schedule, menu: menu, image: UIImage(named: imageNames[i]),
            phoneNumber: phone, website: "None Provided"))
    }
    return out
}