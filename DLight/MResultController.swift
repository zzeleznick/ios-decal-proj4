//
//  MResultController.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/26/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MResultController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var myTable: UITableView!
    var myMap: MKMapView!
    
    var height: CGFloat!
    var width: CGFloat!
    let cellHeight: CGFloat = 120
    
    let restaurants = generateSampleRestaurants()
    
    var geoCoder = CLGeocoder()
    var locationManager: CLLocationManager!
    
    var dragPin: MKPointAnnotation!
    
    var searchRadius = 500
    var searchCircle: MKCircle!
    
    var location: CLLocation! {
        didSet { // update when set
            print("Found Your Location \(location.coordinate)")
        }
    }
    
    func placeElements() {
        view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationItem.title = "Profile"
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        let mapFrame = CGRect(x: 0, y: 0, width: width, height: 200)
        myMap = MKMapView(frame: mapFrame)
        view.addSubview(myMap)
        let tableFrame = CGRect(x: 0, y: 200, width: width, height: height-200)
        myTable = UITableView(frame: tableFrame)
        view.addSubview(myTable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placeElements()
        
        myTable.rowHeight = cellHeight
        myTable.registerClass(MRestaurantCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self

        self.myMap.delegate = self
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "addPin:")
        
        gestureRecognizer.numberOfTouchesRequired = 1
        self.myMap.addGestureRecognizer(gestureRecognizer)
    }
    
    func addPin(gestureRecognizer: UIGestureRecognizer) {
        print("Add Pin triggered")
        let touchPoint = gestureRecognizer.locationInView(myMap)
        let newCoords = myMap.convertPoint(touchPoint, toCoordinateFromView: myMap)
        if dragPin != nil {
            dragPin.coordinate = newCoords
        }
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Touch Start on screen at \(touchPoint)")
            if dragPin != nil {
                myMap.removeAnnotation(dragPin)
            }
            dragPin = MKPointAnnotation()
            dragPin.title = "Search Location"
            dragPin.coordinate = newCoords
            myMap.addAnnotation(dragPin)
            /* searchCircle = MKCircle(centerCoordinate: newCoords, radius: CLLocationDistance(searchRadius)) // r in meters
            */
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Touch End on screen at \(touchPoint)")
            // dragPin = nil
        }
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
        
        self.loadMapView() // Load the map with location
        
        locationManager.stopUpdatingLocation() // save the battery
        geoCoder.reverseGeocodeLocation(location) {
            (placements, myError) -> Void in
            if let error = myError { // handle error
                print(error)
            }
            else { // reverse geocode returns results
                if let placement = placements?.first {
                    print("\(placement.postalCode!)")
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
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            pos, regionRadius, regionRadius)
        self.myMap.setRegion(coordinateRegion, animated: true)
        self.myMap.showsUserLocation = true
        self.myMap.userTrackingMode = .Follow
        print("User tracking is \(self.myMap.userLocationVisible) and at \(self.myMap.userLocation.coordinate)")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            pinAnnotationView.pinTintColor = UIColor(hue: 187, saturation: 76, brightness: 95, alpha: 100)
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            return pinAnnotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let lat = view.annotation?.coordinate.latitude
        let lon = view.annotation?.coordinate.longitude
        print("Selected pin at(\(lat!), \(lon!))")
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
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MRestaurantCell
        let name = restaurants[idx].name
        let loc = restaurants[idx].businessInfo.address
        
        cell.nameLabel.text = name
        cell.locationLabel.text = loc
        cell.setBounds()
        if let image = restaurants[idx].image {
            print("Image loading")
            cell.myImageView.contentMode = .ScaleAspectFill
            cell.myImageView.image = image
        }
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("User will tap \(indexPath.row)")
        // performSegueWithIdentifier("TableToDetail", sender: self)
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dest = RestaurantDetailViewController()
        dest.restaurant = restaurants[indexPath.row]
        dest.view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationController?.pushViewController(dest, animated: true)
    }
    
    
}