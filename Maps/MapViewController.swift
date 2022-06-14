//
//  MapViewController.swift
//  Maps
//
//  Created by Илья Дунаев on 13.06.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager!
    var currentLocationMarker: GMSMarker?
    
    // Центр Москвы
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 55.7522, longitude: 37.6156)

    override func viewDidLoad() {
        super.viewDidLoad()

        zoomToCoordinates(defaultCoordinate)
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }

    func startMonitoringLocation() {
        mapView.isMyLocationEnabled = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.activityType = CLActivityType.automotiveNavigation
            locationManager.distanceFilter = 1
            locationManager.headingFilter = 1
            locationManager.requestWhenInUseAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }
    }

    func stopMonitoringLocation() {
        mapView.isMyLocationEnabled = false
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }

    func zoomToCoordinates(_ coordinates: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 17)
        mapView.camera = camera
    }
    
    @IBAction func stopTracking(_ sender: Any) {
        stopMonitoringLocation()
    }

    @IBAction func currentLocation(_ sender: Any) {
        startMonitoringLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            currentLocationMarker?.position = lastLocation.coordinate
            
            // Add location Pin
            let marker = GMSMarker(position: lastLocation.coordinate)
            marker.map = mapView
            
            self.zoomToCoordinates(lastLocation.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager ERROR -> \(error.localizedDescription)")
    }
}
