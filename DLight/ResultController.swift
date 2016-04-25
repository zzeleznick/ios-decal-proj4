//
//  ResultController.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ResultController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var myMap: MKMapView!
    
    private let names = ["Restaurant 1", "Restaurant 2", "Restaurant 3",
                        "Cafe 1", "Cafe 2", "Cafe 3"]
    private let locations = ["2258 Haste St", "2190 Haste St", "2054 Durant Ave",
                        "2050 Durant Ave", "1950 Durant Ave", "1600 Telegraph Ave"]
    
    let restaurants = generateSampleRestaurants()
    
    var geoCoder = CLGeocoder()
    var locationManager: CLLocationManager!
    var location: CLLocation! {
        didSet { // update when set
            print("Found Your Location \(location.coordinate)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission() {
            print("Success")
        }
    }
    
    func triggerLocationUpdate() {
        print("Location requested")
        locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate
    // Triggered by .startUpdating Location
    // Will update the location and the zipcode on screen
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location Manager invoked")
        location = (locations).last!
        locationManager.stopUpdatingLocation() // save the battery
        geoCoder.reverseGeocodeLocation(location) {
            (placements, myError) -> Void in
            if myError != nil { // handle error
                print(myError)
            }
            else {
                if let placement = placements?.first {
                    print("\(placement.postalCode!)")
                    self.loadMapView()
                    // self.zipInput = "\(placement.postalCode!)"
                    // self.textField.text = self.zipInput
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print("Did update to new location")
    }
    
    func loadMapView() {
        print("Loading map View")
        let pos = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: pos, span: span)
        self.myMap.setRegion(region, animated: true)
        self.myMap.showsUserLocation = true
        self.myMap.userTrackingMode = .Follow
        print("User tracking is \(self.myMap.userLocationVisible) and at \(self.myMap.userLocation.coordinate)")
    }
    
    func checkCoreLocationPermission(onSuccess: () -> ()) {
        // Note that plist must have the row "NSLocationWhenInUseUsageDescription"
        // this allows us to access location
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            /* Calling this method causes the location manager to obtain an initial location fix (which may take several seconds) and notify your delegate by calling its locationManager:didUpdateLocations: method.
            */
            print("Authorized to use location")
            onSuccess()
        }
        else if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .Restricted {
            // should trigger alert
            print("Unauthorized to use location")
        }
    }
    
    /* Gets either a zipcode or location and
     * then calls the completion function on the result
    
    func locationPipe(completion: Int -> () ) {
        if location != nil && !zipCodeMode {
            completion(1)
        }
        else {
            let zipcode = textField.text!
            geoCoder.geocodeAddressString(zipcode){ (placemarks, error) -> Void in
                print("Entering Zipcode Conversion")
                if let firstPlacemark = placemarks?[0] {
                    self.location = firstPlacemark.location!
                    completion(2)
                }
                else {
                    print("USED \(zipcode)")
                    print(error)
                    self.notifyBadZipcode(zipcode)
                }
            }
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Returning to view
    override func viewWillAppear(animated: Bool) {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
        // return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RestaurantCell
        
        let name = restaurants[idx].name
        let loc = restaurants[idx].businessLocation.address
        // let name = names[idx]
        // let loc = locations[idx]
        
        cell.nameLabel.text = name
        cell.locationLabel.text = loc
        cell.nameLabel.textColor = UIColor(white:0, alpha: 1.0)
        cell.locationLabel.textColor = UIColor(white:0, alpha: 1.0)
        cell.locationLabel.font = UIFont(name: Theme.fontName, size: Theme.titleSize)
        cell.nameLabel.font = UIFont(name: Theme.fontName, size: Theme.titleSize)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("User will tap \(indexPath.row)")
        // performSegueWithIdentifier("TableToDetail", sender: self)
        return indexPath
    }
    
    
}