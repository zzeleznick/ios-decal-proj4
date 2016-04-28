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

class ResultController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var myMap: MKMapView!
    
    var API: FirebaseAPI!
    var helper: LocationHelper!
    
    let restaurants = generateSampleRestaurants()
    var geoCoder = CLGeocoder()
    var dragPin: MKPointAnnotation!
    
    var searchRadius = 500
    var searchCircle: MKCircle!
    
    var location: CLLocation = CLLocation(latitude: 37.8716452,
        longitude: -122.253818)
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTable.separatorStyle = .None
        API = FirebaseAPI()
        helper = LocationHelper()
        // print("Biz \(helper.places)")
        // initializePlaces()
    }
    
    func initializePlaces() {
        for place in helper.places {
            API.setChildValue(place.uniqueID, value: place.dict)
            API.geoSet(place.uniqueID, location: place.location) {
                print("Added \(place.name)")
            }
        }
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
    
    
}

extension ResultController: UITableViewDelegate, UITableViewDataSource {
    // MARK : Table Logic
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
        // return names.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // pass
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RestaurantCell
        
        let name = restaurants[idx].name
        let loc = restaurants[idx].businessInfo.address
        if let image = restaurants[idx].image {
            cell.myImage.clipsToBounds = true
            cell.myImage.contentMode = UIViewContentMode.ScaleAspectFill
            cell.myImage.image = image
        }
        cell.nameLabel.text = name
        cell.locationLabel.text = loc
        cell.selectionStyle = UITableViewCellSelectionStyle.None
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

extension ResultController: MKMapViewDelegate {
    
    func additionalSetup() {
        print("Injection")
        myMap.delegate = self
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "addPin:")
        gestureRecognizer.numberOfTouchesRequired = 1
        myMap.addGestureRecognizer(gestureRecognizer)
    }
    
    func addPlaceToMap(place: BusinessInfo) {
        let placePin = PlacePin() // MKPointAnnotation()
        placePin.title = place.name
        placePin.subtitle = place.address
        placePin.coordinate = place.location.coordinate
        placePin.imageReference = "CafeMilan"
        myMap.addAnnotation(placePin)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlacePin {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            // pinAnnotationView.detailCalloutAccessoryView
            pinAnnotationView.image =  UIImage(named: annotation.imageReference)
            pinAnnotationView.pinTintColor = UIColor.blueColor()
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            let myImageView = UIImageView(image: UIImage(named: annotation.imageReference))
            myImageView.frame = CGRect(x: 0, y: 0, width: 75, height: 50)
            myImageView.contentMode = .ScaleAspectFit;
            pinAnnotationView.leftCalloutAccessoryView = myImageView;
            return pinAnnotationView
        }
        else{
            print("Added \(annotation.self)")
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let lat = view.annotation?.coordinate.latitude
        let lon = view.annotation?.coordinate.longitude
        print("Selected pin at(\(lat!), \(lon!))")
    }

}

extension ResultController: CLLocationManagerDelegate {
    
    func foundLocation(loc: CLLocation) {
        print("Found location \(loc)")
        let pos = location.coordinate
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
        pos, regionRadius, regionRadius)
        self.myMap.setRegion(coordinateRegion, animated: true)
        self.myMap.showsUserLocation = true
        self.myMap.userTrackingMode = .Follow
        // print("User tracking is \(self.myMap.userLocationVisible) and at \(self.myMap.userLocation.coordinate)")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let pos = location.coordinate
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            pos, regionRadius, regionRadius)
        self.myMap.setRegion(coordinateRegion, animated: false)
        additionalSetup()
        placeBusinesses()
    }
    
    func placeBusinesses() {
        for place in helper.places {
            addPlaceToMap(place)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // setupMap()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
        
    }
    
    // MARK: - CLLocationManagerDelegate
    // Triggered by .startUpdating Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location Manager invoked")
        location = (locations).last!
        foundLocation(location) // Load the map with location
        locationManager.stopUpdatingLocation() // save the battery
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print(status)
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func checkCoreLocationPermission() {
        // Note that plist must have the row "NSLocationWhenInUseUsageDescription"
        // this allows us to access location
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            print("Authorized to use location")
            locationManager.startUpdatingLocation()
            /* Calling this method causes the location manager to obtain an initial location fix (which may take several seconds) and notify your delegate by calling its locationManager:didUpdateLocations: method.
            */
        }
        else if CLLocationManager.authorizationStatus() == .NotDetermined {
            print("Access not determined")
            locationManager.requestWhenInUseAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .Restricted {
            // should trigger alert
            print("Unauthorized to use location")
        }
    }
    
}