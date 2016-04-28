//
//  FirebaseAPI.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/28/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//
import Firebase
import GeoFire

class FirebaseAPI {
    var ref: Firebase!
    var bizRef: Firebase!
    var geo: GeoFire!
    init() {
        ref = Firebase(url: "https://geomapper.firebaseio.com/")
        geo = GeoFire(firebaseRef: ref.childByAppendingPath("locations"))
        bizRef = ref.childByAppendingPath("businesses")
        // setHQ()
    }
    
    func setChildValue(child:String, value: AnyObject) {
        let db = bizRef.childByAppendingPath(child)
        db.setValue(value) { (error, db) in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                print("Saved object successfully!")
            }
        }
    }
    
    func geoSet(key: String, location: CLLocation, onSucess: () -> ()) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        geo.setLocation(CLLocation(latitude: lat, longitude: lon), forKey: key) { (error) in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                print("Saved location successfully!")
                onSucess()
            }
        }
    }
    
    func setHQ() {
        self.geoSet("haas-hq", location: CLLocation(latitude: 37.8716452, longitude: -122.253818)) {
            self.get("haas-hq")
        }
    }
    
    func get(key:String) {
        print("Looking for \(key)")
        geo.getLocationForKey(key, withCallback: { (location, error) in
            if (error != nil) {
                print("An error occurred getting the location for \(key): \(error.localizedDescription)")
            } else if (location != nil) {
                print("Location for \(key) is [\(location.coordinate.latitude), \(location.coordinate.longitude)]")
            } else {
                print("GeoFire does not contain a location for \(key)")
            }
        })
    }
}
