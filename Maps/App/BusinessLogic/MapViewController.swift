//
//  MapViewController.swift
//  Maps
//
//  Created by Илья Дунаев on 13.06.2022.
//

import UIKit
import GoogleMaps
import CoreLocation
import RealmSwift

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager!
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    let DB = DatabaseService()
    var pathRecordStatus: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
        configureLocationManager()
        
    }
    
    func configureMap() {
        self.locationManager?.requestLocation()
        self.mapView.isMyLocationEnabled = true

        if let coordinate = self.locationManager?.location?.coordinate {
            let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
            self.mapView.camera = camera
        }
    }
    
    func configureLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.allowsBackgroundLocationUpdates = true
        self.locationManager?.pausesLocationUpdatesAutomatically = false
        self.locationManager?.startMonitoringSignificantLocationChanges()
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager?.activityType = CLActivityType.automotiveNavigation
        self.locationManager?.distanceFilter = 1
        self.locationManager?.headingFilter = 1
        self.locationManager?.startUpdatingLocation()
    }

    func stopMonitoringLocation() {
        self.mapView.isMyLocationEnabled = false
        self.locationManager?.stopMonitoringSignificantLocationChanges()
        self.locationManager?.stopUpdatingLocation()
    }
    
    func showTrackError() {
        let alert = UIAlertController(title: "Внимание", message: "Идет запись маршрута, вы хотите остановить запись и сохранить её?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.addLocationsToDB()
            self.stopAndClearCoordinates()
            self.loadTrack()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func stopAndClearCoordinates() {
        self.routePath?.removeAllCoordinates()
        self.locationManager?.stopMonitoringSignificantLocationChanges()
        self.locationManager?.stopUpdatingLocation()
        self.pathRecordStatus = false
    }
    
    func loadTrack() {
        if let coornidates = self.DB.read(locationsObject: LocationModel.self) as? [LocationModel]  {
            self.route?.map = nil
            self.route = GMSPolyline()
            self.routePath = GMSMutablePath()
            
            for coornidate in coornidates {
                self.routePath?.add(CLLocationCoordinate2DMake(coornidate.latitude, coornidate.longitude))
            }
            
            self.route?.path = self.routePath
            route?.strokeWidth = 3
            route?.strokeColor = .blue
            self.route?.map = self.mapView
            
            let bounds = GMSCoordinateBounds(path: self.routePath!)
            let update = GMSCameraUpdate.fit(bounds)
            self.mapView.animate(with: update)
        }
    }
    
    func addLocationsToDB() {
        guard let path = self.routePath else { return }
        
        var items: [CLLocationCoordinate2D] = []
        for i in 0..<path.count() {
            let coordinate = path.coordinate(at: i)
            items.append(coordinate)
        }
        
        let mapCoordinate = items.map { LocationModel(data: $0) }
        
        self.DB.delete(locationsObject: LocationModel.self)
        self.DB.add(locations: mapCoordinate)
    }
    
    func trackRecord() {
        self.route?.map = nil
        self.route = GMSPolyline()
        self.routePath = GMSMutablePath()
        self.route?.map = self.mapView
        self.locationManager?.startUpdatingLocation()
        self.pathRecordStatus = true
    }
    
    @IBAction func showMyLocation(_ sender: Any) {
        self.configureMap()
    }
    
    @IBAction func startPathRecord() {
        self.trackRecord()
    }
    
    @IBAction func stopRouteTrack() {
        self.addLocationsToDB()
        self.stopAndClearCoordinates()
    }
    
    @IBAction func showPreviosTrack() {
        if self.pathRecordStatus {
            self.showTrackError()
        } else {
            self.loadTrack()
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
                        
                self.routePath?.add(location.coordinate)
                self.route?.path = self.routePath
                let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
                self.mapView.animate(to: position)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager ERROR -> \(error.localizedDescription)")
    }
}
