//
//  LocationHelper.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/28/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import MapKit

extension CLAuthorizationStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .AuthorizedWhenInUse: return "Authorized when in use"
        case .AuthorizedAlways: return "Authorized always"
        case .Restricted: return "Restricted"
        case .Denied: return "Denied"
        default: return "Undetermined"
        }
    }
}

class PlacePin: MKPointAnnotation {
    var imageReference: String!
    func linkImageReference(reference: String) {
        self.imageReference = reference
    }
}

class LocationHelper {
    var places: [BusinessInfo]!
    init() {
        places = [BusinessInfo]()
        let path = NSBundle.mainBundle().pathForResource("places", ofType: "plist")
        let placelist = NSArray.init(contentsOfFile: path!)
        for place in placelist! {
            if let obj = place as? [String: AnyObject] {
                let name = obj["name"] as! String
                let address = obj["address"] as! String
                let city = "Berkeley"
                let state = "CA"
                let zipcode = "94704"
                let place = BusinessInfo(name: name, address: address,
                    city: city, state: state, zipCode: zipcode, zipExtension: nil)
                let loc = obj["location"] as! NSArray
                let lat = loc[0] as! Double
                let lon = loc[1] as! Double
                let location = CLLocation(latitude: CLLocationDegrees(lat), longitude:  CLLocationDegrees(lon))
                place.location = location
                places.append(place)
            }
        }
    }
}