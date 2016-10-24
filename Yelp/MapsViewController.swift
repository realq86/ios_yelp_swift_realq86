//
//  MapsViewController.swift
//  Yelp
//
//  Created by Developer on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CircularSpinner

class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    var businessesArray = [Business]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
        
        self.setupCoreLocation()
        
//        let newLocation = CLLocationCoordinate2D(latitude: 37.7833, longitude:  -122.4167)
//        self.addAnnotationAtCoordinate(coordinate: newLocation)
        self.loadBusinessesToAnnotation()
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }

    func setupCoreLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func loadBusinessesToAnnotation() {
        
        for biz in self.businessesArray {
            self.addAnnotationAtCoordinate(coordinate: biz.gpsData!, withAnnotation: biz.name!)
        }
        
    }
    
    // MARK: - Core Location Delegate
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    // Setup location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    
    //Helper function to create annotation
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, withAnnotation annotationTitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = annotationTitle
        mapView.addAnnotation(annotation)
    }
    
    
    // MARK: - MapView Deleage
    
    public func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        CircularSpinner.useContainerView(self.view)
        CircularSpinner.show("Loading...", animated: true, type: .indeterminate)
    }
    
    public func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        CircularSpinner.hide()
    }
    
    public func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        CircularSpinner.hide()

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotationView"
        
        // custom image annotation
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        else {
            annotationView!.annotation = annotation
        }
        annotationView!.image = UIImage(named: "pin")
        
        return annotationView
    }
    
    // MARK: - Navigation

    @IBAction func touchOnDone(_ sender: AnyObject) {
        self.dismiss(animated: true) { 
            
        }
    }
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
