//
//  FeedViewController.swift
//  CrimeMap
//
//  Created by Elysia Hung on 4/6/22.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    

    @IBOutlet weak var mapView: MKMapView!
    
    let location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
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
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true;
        //Working on the annotationsa and getting a detail page up and running
        let sampleAnnotationPin = MKPointAnnotation()
        sampleAnnotationPin.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.001, longitude: location.coordinate.longitude + 0.001)
        sampleAnnotationPin.title = "Mugging"
        mapView.addAnnotation(sampleAnnotationPin)
        
    }
    
    @IBAction func logUserOut(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let
        delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
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
