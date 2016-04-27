//
//  Profile.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/23/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    static func random(length: Int = 20) -> String {
        
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.startIndex.advancedBy(Int(randomValue))])"
        }
        
        return randomString
    }
}

class CenterScaleToFitImageView: UIImageView {
    override var bounds: CGRect {
        didSet {
            adjustContentMode()
        }
    }
    
    override var image: UIImage? {
        didSet {
            adjustContentMode()
        }
    }
    
    func adjustContentMode() {
        guard let image = image else {
            return
        }
        if image.size.width > bounds.size.width ||
            image.size.height > bounds.size.height {
                contentMode = .ScaleAspectFit
        } else {
            contentMode = .ScaleAspectFill
        }
    }
}

enum DiabeticStatus:Int, CustomStringConvertible {
    
    case NONE = 0, TYPEI, TYPEII
    
    var description:String {
        switch self {
        case .NONE: return "None"
        case .TYPEI: return "Type I"
        case .TYPEII: return "Type II"
        }
    }
    func toString() -> String {
        return self.description
    }
}

enum ActivityLevel:Int, CustomStringConvertible {
    
    case LOW = 0, MEDIUM, HIGH
    
    var description:String {
        switch self {
        case .LOW: return "Low Activity"
        case .MEDIUM: return "Medium Activity"
        case .HIGH: return "High Activity"
        }
    }
    func toString() -> String {
        return self.description
    }
}

class AgeRange: CustomStringConvertible {
    var age: Int!
    init(age: Int) {
        self.age = age
    }
    var description:String {
        switch self.age {
        case let age where age >= 90:
            return "90+"
        case 75..<90: return "75-90"
        case 60..<75: return "60-75"
        case 50..<60: return "50-60"
        case 40..<50: return "40-50"
        case 35..<40: return "35-40"
        case 30..<35: return "30-35"
        case 25..<30: return "25-30"
        case 20..<25: return "20-25"
        case 16..<20: return "16-20"
        case 0..<16: return "Under 16"
        default: return "Unspecified"
        }
    }
}

class Restrictions:  CustomStringConvertible {
    var members: [String]!
    init(members: [String]) {
        self.members = members
    }
    var description: String {
        return self.members.joinWithSeparator(", ")
    }

}

class Profile: CustomStringConvertible {
    let randID = String.random(32)
    var name: String!
    var ageRange: AgeRange!
    var diabeticStatus: DiabeticStatus!
    var activityLevel: ActivityLevel!
    var intakeRestrictions: Restrictions!
    var dietaryRestrictions: Restrictions!
    
    init(name:String, age: Int, diabetes: Int, activity: Int,
        intakeRestrictions: [String], dietaryRestrictions: [String]) {
            self.name = name
            self.ageRange = AgeRange(age: age)
            self.diabeticStatus = DiabeticStatus(rawValue: diabetes)
            self.activityLevel = ActivityLevel(rawValue: activity)
            self.intakeRestrictions = Restrictions(members: intakeRestrictions)
            self.dietaryRestrictions = Restrictions(members: dietaryRestrictions)
    }
    lazy var dict: [String:String] = {
        [unowned self] in
        let out = ["Name": self.name!, "Age Range": "\(self.ageRange!)",
            "Diabetic Status": "\(self.diabeticStatus!)",
            "Activity Level": "\(self.activityLevel!)",
            "Intake Restrictions": "\(self.intakeRestrictions!)",
            "Dietary Restrictions": "\(self.dietaryRestrictions!)",
            ]
        return out }()
    
    var description: String {
        let out =  "Profile{(\(self.name)}"
        return out
    }
}