//
//  TableViewController.swift
//  CrimeMap
//
//  Created by Jiatai Sun on 4/13/22.
//

import UIKit
import Parse
import Alamofire
import MapKit

class TableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isUserInteractionEnabled = true
        
        
        let query = PFQuery(className: "Incidents")
        query.includeKey("reporter")
        query.limit = 50
        
        query.findObjectsInBackground { posts, Error in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let post = posts[indexPath.row]
        
        cell.IncidentLabel.text = post["incident"] as? String
        cell.DetailLabel.text = post["detail"] as? String
        //        cell.LongtitudeLabel.text = post["Longtitude"] as? String
        //        cell.LatitudeLabel.text = post["Latitude"] as? String
        //cell.LocationLabel.text = "Location:"
        let location = CLLocationCoordinate2D(latitude: Double(post["Latitude"] as! String)! , longitude: Double(post["Longtitude"] as! String)!)
        findAddressFromCoords(location: location, cell: cell)
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //         tableView.isUserInteractionEnabled = false
        let main = UIStoryboard(name: "Main", bundle: nil)
        let annotationView = main.instantiateViewController(withIdentifier: "AnnotationInfoViewController") as! AnnotationInfoViewController
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        self.present(annotationView, animated: true)
        annotationView.setLabelAndDesc(label: cell.IncidentLabel!.text!, desc: cell.DetailLabel!.text!)
        //         if(annotationView.isBeingDismissed)
        //         {
        //             print("something")
        //         }
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func findAddressFromCoords(location:CLLocationCoordinate2D, cell: TableViewCell)  {
        let geoCoder = CLGeocoder()
        let clloc = CLLocation(latitude: CLLocationDegrees(location.latitude),longitude:  CLLocationDegrees(location.longitude))
        print(clloc.coordinate.longitude)
        print(clloc.coordinate.latitude)
        geoCoder.reverseGeocodeLocation(clloc) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            print("\n")
            print("lat: \(clloc.coordinate.latitude)  \(placemark.thoroughfare ?? "N/A")")
            print("long: \(clloc.coordinate.longitude)")
            
            let streetNum = placemark.subThoroughfare ?? ""
            let streetAdd = placemark.thoroughfare ?? ""
            let locality = placemark.locality ?? ""
            let streetCountry = placemark.country ?? ""
            let ocean = placemark.ocean ?? ""
            
            
            if(streetNum + streetAdd + streetCountry + locality + ocean  == "")
            {
                cell.AddressLabel.text = "N/A"
            }
            else{
                var completeStr = streetNum+" "+streetAdd+" "
                completeStr += locality + " "
                completeStr += ocean + " "
                completeStr += streetCountry
                
                completeStr = completeStr.trimmingCharacters(in: .whitespacesAndNewlines)
                
                
                cell.AddressLabel.text = completeStr
            }
            
            
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
