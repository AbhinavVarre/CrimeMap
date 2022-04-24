//
//  UserPinPostViewController.swift
//  CrimeMap
//
//  Created by Abhinav Varre on 4/23/22.
//

import UIKit
import CoreLocation
import MapKit
import Parse

class UserPinPostViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addButton: UIButton!
    var pinLoc: CLLocation?
    let location = CLLocationManager()
    var posts = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        mapView.reloadInputViews()
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            renderLocation(location: location)
        }
    }
    
    func renderLocation( location: CLLocation) {
        
        
        //The following makes it so that the map zooms in on the users location by default
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //Changing the delta values below adjusts the level of zoom - smaller means more zoomed in
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
        mapView.showsUserLocation = true;
        //Working on the annotationsa and getting a detail page up and running
        mapView.addAnnotations(annotationsArrayGlobal)
        
    }

    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @IBAction func addPin(_ sender: Any) {
        let loc = getCenterLocation(for: mapView)
        let main = UIStoryboard(name: "Main", bundle: nil)
        let postViewController = main.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        present(postViewController, animated: true)
        //        print("lat of chosen: \(String(loc.coordinate.latitude))")
        //        print("long of chosen: \(String(loc.coordinate.latitude))")
        postViewController.LocationField.text = String(loc.coordinate.latitude)
        postViewController.LongtitudeField.text = String(loc.coordinate.longitude)
        //self.dismiss(animated: true)
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
