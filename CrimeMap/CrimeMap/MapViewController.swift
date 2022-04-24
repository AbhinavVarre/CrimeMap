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

var annotationsArrayGlobal = [CustomAnnotation]()

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var posts = [PFObject]()
    let location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
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
  
    @IBAction func addPinTransition(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let userPinPostViewController = main.instantiateViewController(withIdentifier: "UserPinPostViewController") as! UserPinPostViewController
        present(userPinPostViewController, animated: true)
        
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
        generateAnnotationList(location: location)
        
    }
    
    func generateAnnotationList(location : CLLocation)
    {
        let annotations = mapView.annotations.filter({ !($0 is MKUserLocation) })
        mapView.removeAnnotations(annotations)
        let query = PFQuery(className:"Incidents")
        query.includeKeys(["incident","Longtitude","Latitude", "detail"])
        query.limit = 20
        do{
            try posts = query.findObjects()
        }catch {
            print("didn't work")
        }
        
        print("counts: \(self.posts.count)")
        
        var annotationArr = [CustomAnnotation]()
        
        print("the count of posts: \(self.posts.count)")
        for post in self.posts{
            let annotationToBeAdded:CustomAnnotation = CustomAnnotation()
            print("running")
            annotationToBeAdded.coordinate = CLLocationCoordinate2D(latitude: Double(post["Latitude"] as! String)! , longitude: Double(post["Longtitude"] as! String)!)
            print("Lat \(Double(post["Latitude"] as! String)!)")
            print("Long \(Double(post["Longtitude"] as! String)!)")
            
            annotationToBeAdded.title = post["incident"] as! String
            annotationToBeAdded.crimeDesc = post["detail"] as! String
            //mapView.addAnnotation(annotationToBeAdded)
            annotationArr.append(annotationToBeAdded)
            
            //annotationToBeAdded.id = post["objectId"]  as! String
            //mapView.addAnnotation(annotationToBeAdded)
        }
        
        
        
        let sampleAnnotationPin: CustomAnnotation = CustomAnnotation()
        sampleAnnotationPin.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.001, longitude: location.coordinate.longitude + 0.001)
        print("Lat cur \(location.coordinate.latitude)")
        print("Long cur \(location.coordinate.longitude)")
        sampleAnnotationPin.title = "Mugging"
        sampleAnnotationPin.crimeDesc = "random info"
        //mapView.addAnnotation(sampleAnnotationPin)
        annotationArr.append(sampleAnnotationPin)
        mapView.addAnnotations(annotationArr)
        annotationsArrayGlobal = annotationArr
        print("arr: \(annotationArr.count)")
        print("num of annots: \(mapView.annotations.count)")
        
        
    }
    
    @IBAction func logUserOut(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let
                delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
        self.present(loginViewController, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let crimeAnnotation = view.annotation as? CustomAnnotation
        {
            let annotationTitle = crimeAnnotation.title
            print("User tapped on annotation with title: \(annotationTitle)")
            let main = UIStoryboard(name: "Main", bundle: nil)
            let annotationView = main.instantiateViewController(withIdentifier: "AnnotationInfoViewController") as! AnnotationInfoViewController
            self.present(annotationView, animated: true)
            annotationView.setLabelAndDesc(label: annotationTitle!, desc: crimeAnnotation.crimeDesc! )
            
        }
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
